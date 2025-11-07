provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  
}

resource "aws_s3_bucket_versioning" "version" {
    bucket = aws_s3_bucket.my_bucket.id 

    versioning_configuration {
      status = var.versioning ? "Enabled" : "Suspended"
}


    }

 resource "aws_s3_bucket_logging" "example" {
   bucket = aws_s3_bucket.my_bucket.id

   target_bucket = aws_s3_bucket.log_bucket.id
   target_prefix = "log/"
 }

