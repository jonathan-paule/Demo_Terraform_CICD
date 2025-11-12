provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
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



