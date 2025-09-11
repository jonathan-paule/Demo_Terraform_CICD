provider "aws" {
  region = "ap-south-1"
  
}

resource "aws_iam_role" "myrole" {
  name = "myrole"
  assume_role_policy = <<EOF
  {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Effect" : "Allow",
        "Principal" : {
          "Service" :"ec2.amazonaws.com"
        }
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "ec2_policy_attach" {
  role = aws_iam_role.myrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role = aws_iam_role.myrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  
}