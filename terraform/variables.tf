variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.micro"
}

variable "project_name" {
  description = "Name of the project for tagging"
  type        = string
  default     = "DynamicStringPoC"
}
