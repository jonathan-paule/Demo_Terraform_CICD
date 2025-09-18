output "instance_pub_ip" {
    value = aws_instance.terraform_test.public_ip
  
}

output "instance_id" {
    value=aws_instance.terraform_test.id  
}

output "private_key_file" {
    value = local_file.myprivatekey.filename
  
}
