provider "aws" {
    region = "ap-south-1"
  
}

provider "aws" {
  alias = "east"
  region = "us-east-1"
  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "version" {
    bucket = aws_s3_bucket.my_bucket.id 

    versioning_configuration {
     status = "Enabled"
   }
 }

 resource "aws_s3_bucket" "east_primary_bucket" {
   provider = aws.east
   bucket   = "tf-test-bucket-west-12345"
 }

 resource "aws_s3_bucket_versioning" "east" {
   provider = aws.east

   bucket = aws_s3_bucket.east_primary_bucket.id
   versioning_configuration {
     status = "Enabled"
   }
 }

resource "aws_iam_role" "east_replication" {
  name = "s3_cross_region_replication_role"

  assume_role_policy = jsondecode({
    Version = "2012-10-17",
    Statement = [{
      Effect= "Allow",
      Principal = { Service = "s3.amazonaws.com" },
      Action = "sts.Assume_Role"
    }]
})
  
}




resource "aws_iam_role_policy" "east_replication_policy" {
  role = aws_iam_role.east_replication.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.my_bucket.arn,
          "${aws_s3_bucket.my_bucket.arn}/*",
          aws_s3_bucket.log_bucket.arn,
          "${aws_s3_bucket.log_bucket.arn}/*"
        ]
      },

      {
        Effect = "Allow",
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:PutObjectAcl"
        ],
        Resource = [
          aws_s3_bucket.east_primary_bucket.arn,
          "${aws_s3_bucket.east_primary_bucket.arn}/*",
          aws_s3_bucket.log_east_bucket.arn,
          "${aws_s3_bucket.log_east_bucket.arn}/*"
        ]
      },

  
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ],
        Resource = aws_kms_key.mykey.arn
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ],
        Resource = aws_kms_key.east_key.arn
      }
    ]
  })
}

 resource "aws_s3_bucket_replication_configuration" "east_primary" {
   depends_on = [aws_s3_bucket_versioning.version,aws_s3_bucket_versioning.east]
   role   = aws_iam_role.east_replication.arn
   bucket = aws_s3_bucket.my_bucket.id

   rule {
     status = "Enabled"

     destination {
       bucket        = aws_s3_bucket.east_primary_bucket.arn
       storage_class = "STANDARD"
     }
     
   }
 }

 resource "aws_s3_bucket" "log_bucket" {
  bucket = var.log_bucket
  
}



resource "aws_kms_key" "mykey" {
  description = "KMS key "
  deletion_window_in_days = 10
  is_enabled              = true
  enable_key_rotation     = true
  policy      = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "default",
    "Statement": [
      {
        "Sid": "DefaultAllow",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::251985278967:root"
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  }
POLICY
}

resource "aws_kms_key" "mykey1" {
  provider = aws.east
  description = "KMS key1 "
   deletion_window_in_days = 10
  is_enabled              = true
  enable_key_rotation     = true
  policy      = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "default",
    "Statement": [
      {
        "Sid": "DefaultAllow",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::251985278967:root"
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  }
POLICY
}

 

resource "aws_s3_bucket_server_side_encryption_configuration" "good_sse_1" {
   bucket = aws_s3_bucket.my_bucket.bucket

   rule {

     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.mykey.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }


resource "aws_s3_bucket_server_side_encryption_configuration" "good_sse_2" {
   bucket = aws_s3_bucket.log_bucket.bucket

   rule {

     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.mykey.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }



resource "aws_s3_bucket_public_access_block" "access_good_1" {
   bucket = aws_s3_bucket.my_bucket.id

   block_public_acls   = true
   block_public_policy = true
   restrict_public_buckets = true
   ignore_public_acls=true
 }

 resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
   bucket = aws_s3_bucket.my_bucket.id
   rule {
    
      id      = "expire"
      status  = "Enabled"
      filter {
        
       prefix = "logs/"
      }
      transition {
        days          = 30
        storage_class = "STANDARD_IA"
    }
  
      expiration  {
        days = 90
    }
   }
  
    rule {

      id = "log"
      status = "Enabled"
      filter{}
      abort_incomplete_multipart_upload {
       days_after_initiation = 7
   }
    
  }
 }

resource "aws_sns_topic" "bucket_notifications" {
  name = "bucket-notifications"
  kms_master_key_id = aws_kms_key.mykey.arn

}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.my_bucket.id

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}



resource "aws_s3_bucket_lifecycle_configuration" "lifecycle1" {
   bucket = aws_s3_bucket.log_bucket.id
   rule {
    
      id      = "expire"
      status  = "Enabled"
      filter {
        
       prefix = "logs/"
      }
      transition {
        days          = 30
        storage_class = "STANDARD_IA"
    }
  
      expiration  {
        days = 90
    }
   }
  
    rule {

      id = "log1"
      status = "Enabled"
      filter{}
      abort_incomplete_multipart_upload {
       days_after_initiation = 7
   }
    
  }
 }



   
 
   


resource "aws_s3_bucket_versioning" "version1" {
    bucket = aws_s3_bucket.log_bucket.id 

    versioning_configuration {
     status = "Enabled"
   }
 }


 resource "aws_s3_bucket" "log_east_bucket" {
   provider = aws.east
   bucket   = "tf-log-bucket-east-123456334"
 }

 resource "aws_s3_bucket_versioning" "log_east_versioning" {
   provider = aws.east

   bucket = aws_s3_bucket.log_east_bucket
   versioning_configuration {
     status = "Enabled"
   }
 }

 resource "aws_s3_bucket_replication_configuration" "log_east" {
   depends_on = [aws_s3_bucket_versioning.version1,aws_s3_bucket_versioning.log_east_versioning]
   role   = aws_iam_role.east_replication.arn
   bucket = aws_s3_bucket.log_bucket.id

   rule {
     status = "Enabled"

     destination {
       bucket        = aws_s3_bucket.log_east_bucket.arn
       storage_class = "STANDARD"
       access_control_translation {
         owner = "Destination"
       }
       encryption_configuration {
         replica_kms_key_id = aws_kms_key.mykey1
       }
     }
     
   }
   
   
 }



resource "aws_s3_bucket_public_access_block" "access_good_2" {
   bucket = aws_s3_bucket.log_bucket.id

   block_public_acls   = true
   block_public_policy = true
   restrict_public_buckets = true
   ignore_public_acls=true
 }



resource "aws_s3_bucket_notification" "bucket_notification1" {
  bucket = aws_s3_bucket.log_bucket.id

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}









    

 resource "aws_s3_bucket_logging" "example" {
   bucket = aws_s3_bucket.my_bucket.id

   target_bucket = aws_s3_bucket.log_bucket.id
   target_prefix = "log/"
 }



