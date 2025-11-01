<h1 align="center">🌳 Terraform AWS Infrastructure Automation 🚀</h1>

<p align="center">
  <b>Automating Multi-Environment AWS Infrastructure using Terraform & GitHub Actions</b>  
  <br>
  <i>Infrastructure as Code | CI/CD | Modular | Scalable | Reusable</i>
</p>

---

## 🧭 Overview

This repository hosts a **comprehensive Terraform-based infrastructure automation project** for deploying and managing **AWS resources** efficiently.  
It includes a fully automated **GitHub Actions CI/CD pipeline** and a clean **multi-environment structure** (Development & Testing).

---

## 🏗️ Project Structure

The project is designed for clarity, scalability, and modularity — separating reusable Terraform modules from environment-specific configurations.

---

## ⚙️ Components Explained

### 📁 **.github/workflows/**
Contains the **GitHub Actions** workflow YAML file responsible for automating the **Terraform lifecycle**:  
`terraform init → terraform plan → terraform apply`  

This ensures every infrastructure change is **tested, reviewed, and deployed automatically**.

---

### 🧩 **terraform-workflow/**
This directory holds all the Terraform configuration files, including the **provider**, **modules**, and **environment folders**.

#### 🔧 **provider.tf**
Defines the **AWS provider**, specifying the region and version constraints to ensure consistency across environments.

---

### 📦 **Modules** (Reusable Infrastructure Components)

Each module follows the **DRY (Don’t Repeat Yourself)** principle, making infrastructure scalable and modular.

| Module | Description |
|:--------|:-------------|
| [**1️⃣ EC2-instance**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/EC2_instance) | Deploys a basic EC2 instance |
| [**2️⃣ EC2-volume**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/EC2_with_volume_attach) | Creates an EC2 instance with an attached EBS volume |
| [**3️⃣ IAM-role-policy**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/IAM_role_policy_attachment) | Configures an IAM Role with required policies |
| [**4️⃣ IAM-user-policy**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/IAM_user_create_policy_attachment) | Creates IAM Users and attaches access policies |
| [**5️⃣ Lambda-API-Gateway**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/Lambda_api_gateway) | Deploys a Lambda function and exposes it via API Gateway |
| [**6️⃣ VPC-network**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/VPC) | Creates a custom VPC with subnets, route tables, and gateways |
| [**7️⃣ S3-bucket**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/s3_creation) | Creates an S3 bucket with versioning and access controls |
| [**8️⃣ RDS-instance**](https://github.com/jonathan-paule/Demo_Terraform_CICD/tree/main/Terraform_workflow/modules/RDS) | Provisions an Amazon RDS instance (MySQL/PostgreSQL) |

---

### 🌍 **terraform-workflow/env/**
Contains **environment-specific configurations** that import and use the reusable modules.  
Each environment maintains its own **S3 remote backend** for isolated and durable state management.

#### 🧪 Environments Included

**1️⃣ dev (Development)**  
- `main.tf` defines the infrastructure for the dev environment.  
- Backend: S3 remote backend for persistent and collaborative state management.  

**2️⃣ test (Testing)**  
- `main.tf` defines the infrastructure for the testing environment.  
- Backend: S3 remote backend ensuring complete isolation from the dev state.

---

## 🔁 CI/CD Integration

The **GitHub Actions pipeline** automates:
- ✅ `terraform init` → Initializes backend  
- ✅ `terraform plan` → Previews infrastructure changes  
- ✅ `terraform apply` → Deploys after approval  

This ensures **continuous integration, automated deployment, and zero manual errors**.

---

## 🏆 Key Highlights

- 🧱 Modularized Infrastructure-as-Code design  
- 🌎 Multi-environment deployment using isolated S3 backends  
- ⚙️ Automated CI/CD pipeline with GitHub Actions  
- 📈 Easy scalability and maintainability  
- 🔁 Promotes best DevOps practices  

---

## 🧑‍💻 Author

**👤 Jonathan Paul E**  
🚀 DevOps & AWS Enthusiast | Terraform • Docker • Kubernetes • GitHub Actions  
🔗 [LinkedIn](https://linkedin.com/in/jonathan-paul218) • [GitHub](https://github.com/jonathan-paule)

---

<p align="center">
  <img src="https://img.shields.io/badge/Infrastructure_as_Code-Terraform-7B42BC?logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/CI/CD-GitHub_Actions-2088FF?logo=github-actions&logoColor=white" />
  <img src="https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws&logoColor=white" />
</p>
