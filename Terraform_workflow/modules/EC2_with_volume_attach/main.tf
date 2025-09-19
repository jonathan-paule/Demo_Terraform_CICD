#to create a key pair and save it on my local


resource "tls_private_key" "mynewkey" {
   algorithm = "RSA"
   rsa_bits = 4096
 }


resource "aws_key_pair" "my_key_pair" {
   key_name = var.key_name
   public_key = tls_private_key.mynewkey.public_key_openssh
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




resource "aws_ebs_volume" "myvolumeadd" {
 availability_zone = var.az
 size              = var.size
}


resource "aws_volume_attachment" "ebs_att" {
 device_name = var.device_name
 volume_id   = aws_ebs_volume.myvolumeadd.id
 instance_id = aws_instance.terraform_test.id


 depends_on = [ aws_instance.terraform_test,aws_ebs_volume.myvolumeadd ]
}


resource "aws_instance" "terraform_test" {
 ami           = var.ami_id
 instance_type = var.instance_type
 key_name = aws_key_pair.my_key_pair.key_name
 availability_zone = var.az
 vpc_security_group_ids = [aws_security_group.ec2_security_group.id]


 tags = {
   Name = "test"
 }
}




