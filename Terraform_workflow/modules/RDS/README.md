🧩 **Module Overview**

**The module (modules/rds-instance) performs the following actions:**

🏗️ Creates an RDS instance with configurable parameters like engine, version, instance class, and storage type.

☁️ Supports Multi-AZ deployment for high availability.

⚙️ Uses a parameter group if provided for database configuration.

💾 Manages backup retention and snapshot settings.

🔐 Accepts input variables for username, password, and DB name for flexibility.

🧠 How to Call the Module (Example for dev environment)

**Create a main.tf inside envs/dev/ and reference the module:**

module "rds_instance" {
  source                  = "../../modules/rds-instance"
  }
