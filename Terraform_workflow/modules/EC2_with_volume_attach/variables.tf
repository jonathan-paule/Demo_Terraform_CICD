variable "key_name" {
    description = "name of key pair"
    type = string
  
}

variable "tags" {
    description = "name of tag"
    type = string
}


variable "sg_name" {
    description = "name of security group"
    type = string
    default = "ec2_sg"
  
}

variable "vpc_id" {
    description = "VPC ID where instance will be launched "
    type = string
      
}
variable "az" {
    description = "AZ for EBS volume"
    type = string
  
}

variable "size" {
    description = "size of ebs volume"
    type = number
    default = 1
  
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t2.micro"

  
}
variable "ami_id" {
    description = "AMI id for the EC2 instance"
    type = string
  
}

variable "device_name" {
    description = "device name for attaching ebs volume"
    type = string
    default = "/dev/sdh"
  
}
