provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod2" {
  source = "../../modules/IAM_user_policy_attachment/"
  user_name= paul
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess","arn:aws:iam::aws:policy/AmazonEC2FullAccess"]

  


}

