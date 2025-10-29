🧩 **Module Overview**

**The module (modules/ec2-instance) performs the following actions:**

🔐 Generates a new RSA private key using the tls_private_key resource

☁️ Creates an AWS key pair using that generated key (key name includes environment name, e.g. dev, test)

🔒 Creates a Security Group that allows:

SSH (port 22)

HTTP (port 80)

HTTPS (port 443)

💾 Creates and attaches an EBS volume to the EC2 instance

🚀 Launches an EC2 instance using the specified AMI, instance type, VPC ID, and availability zone

🏷️ Applies environment-specific naming for key pair and security group using the var.env variable

🧠 How to Call the Module (Example: dev Environment)

**Create a main.tf file inside your envs/dev/ directory and reference the EC2 module:**

module "ec2_instance" {
  source         = "../../modules/ec2-instance"
}

🧭 **Usage Steps**
terraform init
terraform plan
terraform apply
