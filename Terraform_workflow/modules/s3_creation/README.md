🧩 **Module Overview**

**The module (modules/s3-bucket) performs the following actions:**

🪣 Creates an S3 bucket with the specified name.

🔁 Enables or suspends versioning on the bucket based on the versioning variable.

🧠 How to Call the Module (Example for dev environment)

**Create a main.tf inside envs/dev/ and reference the module:**

module "s3_bucket" {
  source       = "../../modules/s3-bucket"
}
