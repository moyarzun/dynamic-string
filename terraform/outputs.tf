output "public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.web.public_ip
}

output "url" {
  description = "The URL to access the dynamic string page"
  value       = "http://${aws_instance.web.public_ip}"
}

output "api_update_endpoint" {
  description = "The API endpoint to update the dynamic string"
  value       = "http://${aws_instance.web.public_ip}/api/string"
}

output "update_string_curl_example" {
  description = "Example curl command to update the dynamic string"
  value       = "curl -X POST -H 'Content-Type: application/json' -d '{\"string\": \"Your Message Here\"}' http://${aws_instance.web.public_ip}/api/string"
}
