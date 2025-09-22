provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod" {
  source = "../../modules/VPC"
  cidr_block = "10.0.0.0/16"
  ami = "ami-02d26659fd82cf299"
  private_cidr ="10.0.2.0/24" 
  public_cidr= "10.0.1.0/24"
  key_name = "vpc_key"
  az = "ap-south-1a"




}

