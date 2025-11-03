# 🧩 Terraform CI/CD Workflow

This workflow automates the process of scanning, planning, and applying Terraform configurations across multiple environments using **GitHub Actions**.

---

## ⚙️ Workflow Overview

### 🔍 1. Checkov Security Scan
- **Purpose:** Performs static code analysis on Terraform files to detect security and compliance issues.
- **Tool:** [Checkov](https://www.checkov.io/)
- **Runs on:** Every push to `Terraform_workflow/env/**`
- **Folder Scanned:** `Terraform_workflow/env/`
- **Outcome:** Fails if misconfigurations are found (can be set to soft-fail if needed).

### 🧭 2. Terraform Plan
- **Purpose:** Initializes Terraform, validates configurations, and generates an execution plan.
- **Strategy:** Runs for each environment (e.g., `dev`, `test`)
- **Actions Used:**
  - `hashicorp/setup-terraform@v3`
  - `aws-actions/configure-aws-credentials@v3`
- **Artifacts Uploaded:** `plan.txt` for each environment.

### 🚀 3. Terraform Apply
- **Purpose:** Applies the Terraform plan to provision infrastructure on AWS.
- **Depends on:** Successful completion of the `plan` job.
- **Performs:** `terraform init`, `terraform plan`, and `terraform apply -auto-approve`

---

## 🧱 Workflow Structure

```yaml
jobs:
  checkov:          # Step 1: Scan infrastructure code
  plan:             # Step 2: Generate plan (runs after checkov)
  terraform_apply:  # Step 3: Apply infrastructure (runs after plan)
