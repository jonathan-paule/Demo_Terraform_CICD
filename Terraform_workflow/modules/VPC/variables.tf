variable "cidr_block" {
    description = "CIDR block for vpc"
    type = string
  
}

variable "public_cidr" {
    description = "cidr block for public subnet"
    type = string
  
}

variable "private_cidr" {
    description = "cidr block for public subnet"
    type = string
  
}

variable "az" {
    description = "az to deploy subnets"
    type = string
}

variable "ami" {
    description = "AMI id to use for ec2s"
    type = string

  
}

variable "instance_type" {
    description = "instance type"
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    description = "name for ec2 key pair"
    type = string
  
}
