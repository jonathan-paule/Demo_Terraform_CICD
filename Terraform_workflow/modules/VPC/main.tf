provider "aws" {
  region = "ap-south-1"
}



# creating vpc


resource "aws_vpc" "main" {
   cidr_block = var.cidr_block
   enable_dns_hostnames = true
   enable_dns_support = true
   tags = {
     Name = "myvpc"
   }
 }


#create pub subnet


resource "aws_subnet" "public" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.public_cidr
   availability_zone = var.az
   map_public_ip_on_launch = true
   tags = {
     Name = "public-subnet"
   }
 }


#create private subnet
resource "aws_subnet" "private" {
   vpc_id = aws_vpc.main.id
   cidr_block = var.private_cidr
   availability_zone = var.az
   tags = {
       Name = "private-subenet"      
   }


}
resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main.id
   tags = {
     Name = "main-igw"
   }
 }


#create route table for pub subnet


resource "aws_route_table" "public" {
   vpc_id = aws_vpc.main.id
   tags = {
     Name = "public-route-table"
   }
 }
resource "aws_route" "public_igw_route" {
   route_table_id = aws_route_table.public.id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }


resource "aws_route_table_association" "public" {
   subnet_id = aws_subnet.public.id
   route_table_id = aws_route_table.public.id


 }


resource "aws_route_table" "private" {
   vpc_id = aws_vpc.main.id
   tags = {
     Name = "private-route-table"
   }
 }


resource "aws_route_table_association" "private" {
   subnet_id = aws_subnet.private.id
   route_table_id = aws_route_table.private.id


 }


#security group


resource "aws_security_group" "pub_sg" {
   name = "pub_sub"
   description = "allow inbound ssh traffic"
   vpc_id = aws_vpc.main.id


   ingress {
       from_port = 22
       to_port = 22
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
   }
 egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_security_group" "private_sg" {
   name= "private_sg"
   description = "allow inbound ssh traffic only from public ec2"
   vpc_id = aws_vpc.main.id


   ingress {
       from_port= 22
       to_port=  22
       protocol= "tcp"
       security_groups= [aws_security_group.pub_sg.id]


   }


   egress {
       from_port = 0
       to_port = 0
       protocol= "-1"
       cidr_blocks= ["0.0.0.0/0"]
   }
}


#to create a key pair and save it on my local


resource "tls_private_key" "mynewkey" {
   algorithm = "RSA"
   rsa_bits = 4096
 }


resource "aws_key_pair" "my_key_pair" {
   key_name = var.key_name
   public_key = tls_private_key.mynewkey.public_key_openssh
 }


#ec2 instance in pub subnet
resource "aws_instance" "public_ec2" {
   ami = var.ami
   instance_type = var.instance_type
   subnet_id = aws_subnet.public.id
   key_name = aws_key_pair.my_key_pair.key_name
   vpc_security_group_ids= [aws_security_group.pub_sg.id]
   tags = {
       Name= "public-ec2"
   }


 }


resource "aws_instance" "private_ec2" {
   ami = var.ami
   instance_type = var.instance_type
   subnet_id = aws_subnet.private.id
   key_name = aws_key_pair.my_key_pair.key_name
   vpc_security_group_ids = [aws_security_group.private_sg.id]
   tags = {
       Name = "Private_ec2"
   }
 }
