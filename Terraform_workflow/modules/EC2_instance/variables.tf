variable "ami_id" {
    description = "AMI id for your instance"
    type = string
  
}
variable "instance_type" {
    description = "ec2 instance type"
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    description = "key name"
    type = string
    default = "my-key-pair"
  
}
variable "sg_name" {
    description = "security group name"
    type = string
    default = "ec2_security_group"

  
}

variable "vpc_id" {
    description = "vpc id of the vpc where ec2 is going to be lanuched"
    type = string
}
variable "tag_name" {
    description = "tag name" 
    type = string
    default = "test"
  
}
