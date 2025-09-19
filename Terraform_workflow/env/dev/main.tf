provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod" {
  source = "../../modules/IAM_user_policy_attached/"
  user_name= john
  policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess","arn:aws:iam::aws:policy/AmazonEC2FullAccess"]

  


}

