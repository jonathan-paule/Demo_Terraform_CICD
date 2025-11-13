provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}


resource "aws_kms_key" "mykey" {
  description             = "KMS key for S3 bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
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
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.my_bucket.id

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}



resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
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



   
 
   

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.log_bucket
  
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



resource "aws_s3_bucket_versioning" "version1" {
    bucket = aws_s3_bucket.log_bucket.id 

    versioning_configuration {
     status = "Enabled"
   }
 }


resource "aws_s3_bucket_versioning" "version" {
    bucket = aws_s3_bucket.my_bucket.id 

    versioning_configuration {
     status = "Enabled"
   }
 }



    

 resource "aws_s3_bucket_logging" "example" {
   bucket = aws_s3_bucket.my_bucket.id

   target_bucket = aws_s3_bucket.log_bucket.id
   target_prefix = "log/"
 }



