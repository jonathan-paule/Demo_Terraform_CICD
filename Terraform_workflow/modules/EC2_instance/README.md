**🧩 Module Overview**

**The module (modules/ec2-instance) performs the following actions:**

🔐 Generates a new RSA private key using the tls_private_key resource

☁️ Creates an AWS key pair using that generated key

💾 Saves the private key locally as a .pem file with secure permissions (0400)

🔒 Creates a Security Group that allows:

SSH (port 22)

HTTP (port 80)

HTTPS (port 443)

🚀 Launches an EC2 instance using the specified AMI, instance type, and VPC ID

🧠 **How to Call the Module (Example: dev Environment)**

Create a main.tf file inside your envs/dev/ directory and reference the EC2 instance creation module:

module "ec2_instance" {
  source         = "../../modules/ec2-instance"
}
