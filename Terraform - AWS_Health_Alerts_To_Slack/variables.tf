variable "aws_region" {
  description = "AWS region to launch resources."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS provider credentials in AWS config file"
  type        = string
  default     = "default"
}

variable "lambda_policy_name" {
  description = "name of lambda policy"
  type        = string
  default     = "lambda_policy_for_lambda_role"
}

variable "iam_role_name" {
  description = "name of iam role for lambda"
  type        = string
  default     = "lambda_cloudWatch_access"
}

variable "iam_role_description" {
  description = "the role/purpose of the iam role created for lambda"
  type        = string
  default     = "lambda to access cloudwatch events and sns"
}

