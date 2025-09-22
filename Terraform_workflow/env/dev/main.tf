provider "aws" {
  region = "ap-south-1"
}

module "EC2_mod" {
  source = "../../modules/Lambda_api_gateway"
  filename = "${path.module}/../../modules/lambda_file.zip"
  function_name= "get_hotel_rooms"
  handler= "lambda_file.lambda_handler"
  runtime= "python3.12"
  filename= "lambda_file.zip"
  route_key= "GET /get_hotel_rooms"




}

