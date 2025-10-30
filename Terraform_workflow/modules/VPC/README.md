**🧩 Module Overview**

**The module (modules/vpc-ec2-setup) performs the following actions:**

🌐 Creates a new VPC with DNS hostnames and DNS support enabled.

🧱 Creates public and private subnets in the specified Availability Zone.

🚪 Attaches an Internet Gateway (IGW) to the VPC for outbound internet access.

🗺️ Configures route tables:

1.Public route table routes traffic to the IGW.

2.Private route table isolates internal resources.

🔐 Creates security groups:

1.Public SG allows inbound SSH from anywhere.

2.Private SG allows SSH only from the public EC2 instance.

🔑 Generates and registers an AWS key pair using a locally created TLS key.

💻 Launches two EC2 instances:

1.One in the public subnet (accessible via SSH).

2.One in the private subnet (accessible only from the public EC2).

🧠 **How to Call the Module (Example for dev environment)**

**Create a main.tf inside envs/dev/ and reference the module:**

module "vpc_ec2_setup" {
  source            = "../../modules/vpc-ec2-setup"
}
