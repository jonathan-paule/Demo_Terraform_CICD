variable "user_name" {
    description = "Iam username"
    type = string

}

variable "policy_arns" {
    description = "list of policy ARNs to attach"
    type = list(string)
    default = [  ]
  
}
