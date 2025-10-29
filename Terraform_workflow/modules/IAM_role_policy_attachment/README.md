🧩 **Module Overview**

**The module (modules/iam-role) performs the following actions:**

🧾 Creates an IAM Role using the specified role_name and assume_role_policy

🔐 Attaches one or more IAM policies to the created role dynamically using a for_each loop

⚙️ Supports multiple policy attachments through the policy_arns variable list

🧠 How to Call the Module (Example: dev Environment)

**Create a main.tf file inside your envs/dev/ directory and reference the IAM Role module:**

module "iam_role" {
  source              = "../../modules/iam-role"
}
