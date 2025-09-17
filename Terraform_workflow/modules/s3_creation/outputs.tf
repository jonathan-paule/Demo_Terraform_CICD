output "bucket_id" {
  description = "bucket ids" 
  value = aws_s3_bucket.my_bucket.id
}
