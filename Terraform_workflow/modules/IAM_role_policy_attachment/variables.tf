variable "role_name" {
    description = "iam role name"
    type = string

  
}

variable "policy_arns" {
    description = "list of policy arns to be attached to the role"
    type = list(string)
    default = [  ]

  
}

variable "assume_role_policy" {
    description = "the assume role policy documents (in JSON)"
    type = string
  
}
