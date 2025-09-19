provider "aws" {
  region = "ap-south-1"
}

module "EC2_module" {
  source = "../../modules/EC_instance/" 
  vpc_id = "vpc-0306a6c9d13570470"
  ami= "ami-02d26659fd82cf299"
  tag_name = "dev"
  


}
