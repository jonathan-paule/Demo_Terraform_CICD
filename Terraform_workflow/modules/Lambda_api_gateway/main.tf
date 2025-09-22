provider "aws" {
  region = "ap-south-1"
}

# IAM role creation


resource "aws_iam_role" "lambda_role" {
 name = "${var.function_name}lambda_role"
 assume_role_policy = <<EOF
 {
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Action": "sts:AssumeRole"
   }
 ]
}


EOF
 }


resource "aws_iam_role_policy_attachment" "lambda_role_attach" {
 role = aws_iam_role.lambda_role.name
 policy_arn= "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
 }


#lambda function creation


resource "aws_lambda_function" "get_hotel_rooms" {
 filename = var.filename
 role = aws_iam_role.lambda_role.arn 
 function_name = var.function_name
 handler = var.handler
 runtime = var.runtime
 architectures = ["x86_64"]
 memory_size = var.memory_size
 timeout = var.timeout
 source_code_hash = filebase64sha256(var.filename)


 }


#create api gateway (http api)
resource "aws_apigatewayv2_api" "http_api" {
 name = "${var.function_name}_http_api"
 protocol_type = "HTTP"


 cors_configuration {
   allow_headers = [ "*" ]
   allow_methods = ["GET","OPTIONS"]
   allow_origins = [ "*" ]
   max_age = 3600
 }


 }




resource "aws_apigatewayv2_integration" "lambda_integration" {
 api_id = aws_apigatewayv2_api.http_api.id
 integration_type = "AWS_PROXY"
 integration_uri = "arn:aws:apigateway:ap-south-1:lambda:path/2015-03-31/functions/${aws_lambda_function.get_hotel_rooms.arn}/invocations"
 integration_method = "POST"
 payload_format_version = "2.0"
 }


resource "aws_apigatewayv2_route" "route" {
 api_id = aws_apigatewayv2_api.http_api.id
 route_key = var.route_key
 target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"


 }


resource "aws_apigatewayv2_stage" "default" {
 api_id = aws_apigatewayv2_api.http_api.id
 name = "$default"
 auto_deploy = true
 }


resource "aws_lambda_permission" "permission" {


 statement_id = "AllowAPIGatewayInvoke"
 action =  "lambda:InvokeFunction"
 function_name = aws_lambda_function.get_hotel_rooms.arn
 principal = "apigateway.amazonaws.com"
 source_arn = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"




}
