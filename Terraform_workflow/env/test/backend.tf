terraform {
  backend "s3" {
    bucket         = "my-tfstate-bucket123"      
    key            = "envs/test/terraform.tfstate" 
    region         = "ap-south-1"
  }
}
