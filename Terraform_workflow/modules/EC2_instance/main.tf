#to create a key pair and save it on my local

resource "tls_private_key" "mynewkey" {
    algorithm = "RSA"
    rsa_bits = 4096
  
}

resource "aws_key_pair" "my_key_pair" {
    key_name = var.key_name
    public_key = tls_private_key.mynewkey.public_key_openssh
  
}
resource "local_file" "myprivatekey" {
    content = tls_private_key.mynewkey.private_key_pem
    filename = "${var.key_name}.pem"
    file_permission = "0400"
  
}
# create security group
resource "aws_security_group" "ec2_security_group" {
    name = var.sg_name
    description = "allow ssh, http and https inbound"
    vpc_id = var.vpc_id

    ingress  {
        from_port= 22
        to_port=  22
        protocol= "tcp"
        cidr_blocks= ["0.0.0.0/0"]

    }
     ingress {
        from_port= 80
        to_port=  80
        protocol= "tcp"
        cidr_blocks= ["0.0.0.0/0"]

    }
     ingress  {
        from_port= 443
        to_port=  443
        protocol= "tcp"
        cidr_blocks= ["0.0.0.0/0"]

    }
     egress  {
        from_port= 0
        to_port=  0
        protocol= "-1"
        cidr_blocks= ["0.0.0.0/0"]


    }
    
    
}


resource "aws_instance" "terraform_test" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = var.tag_name
  }
}
 
