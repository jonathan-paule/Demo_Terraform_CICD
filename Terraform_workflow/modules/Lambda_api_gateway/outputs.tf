output "api_endpoint" {
 value = aws_apigatewayv2_api.http_api.api_endpoint
 description = "http api endpoint"
}


output "invoke_url" {
 value = "${aws_apigatewayv2_api.http_api.api_endpoint}${split("",var.route_key)[1]}"
 description = "invoke url"
 }
