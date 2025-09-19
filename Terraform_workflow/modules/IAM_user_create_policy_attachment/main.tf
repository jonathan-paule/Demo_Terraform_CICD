resource "aws_iam_user" "user" {
 name = var.user_name
}



resource "aws_iam_user_policy_attachment" "test-attach" {
 for_each = toset(var.policy_arns)
 user       = aws_iam_user.user.name
 policy_arn = each.value 
}

