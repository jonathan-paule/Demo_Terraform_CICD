provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod" {
  source = "../../modules/EC2_with_volume_attach"
  az= "ap-south-1a"
  ami_id= "ami-02d26659fd82cf299"
  vpc_id= "vpc-0306a6c9d13570470"



}

