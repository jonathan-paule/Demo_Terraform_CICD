terraform {
  backend "s3" {
    bucket         = "my-tfstate-bucket123"      
    key            = "envs/dev/terraform.tfstate" 
    region         = "ap-south-1"
  }
}
