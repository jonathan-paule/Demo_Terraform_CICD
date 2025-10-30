🧩 **Module Overview**

**The module (modules/lambda-api) performs the following actions:**

🔐 Creates an IAM Role for the Lambda function with the AWSLambdaBasicExecutionRole policy attached.

⚙️ Deploys a Lambda function using the specified handler, runtime, timeout, and memory settings.

🌐 Creates an HTTP API Gateway with CORS configuration enabled.

🔗 Integrates the API Gateway with the Lambda function using an AWS_PROXY integration.

🛣️ Defines a route (e.g., GET /hotels) that triggers the Lambda function.

🚀 Creates a default stage with auto_deploy enabled.

🔒 Adds Lambda permission allowing API Gateway to invoke the function.

🧠 How to Call the Module (Example for dev environment)

**Create a main.tf inside envs/dev/ and reference the module:**

module "lambda_api" {
  source         = "../../modules/lambda-api"
}
