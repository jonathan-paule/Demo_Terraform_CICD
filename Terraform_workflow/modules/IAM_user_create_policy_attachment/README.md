🧩 **Module Overview**

**The module (modules/iam-user) performs the following actions:**

👤 Creates an IAM User with the specified user_name

🔐 Attaches one or more IAM policies to the created user dynamically using a for_each loop

⚙️ Supports multiple policy attachments through the policy_arns variable list

🧠 How to Call the Module (Example: dev Environment)

**Create a main.tf file inside your envs/dev/ directory and reference the IAM User module:**

module "iam_user" {
  source        = "../../modules/iam-user"
}
