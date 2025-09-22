provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod" {
  source = "../../modules/s3_creation"
  bucket_name= "hi123bucket9734"

}
