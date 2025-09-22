provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod" {
  source = "../../modules/IAM_user_create_policy_attachment"
  user_name= "james_ken"
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess","arn:aws:iam::aws:policy/AmazonEC2FullAccess"]

  


}

