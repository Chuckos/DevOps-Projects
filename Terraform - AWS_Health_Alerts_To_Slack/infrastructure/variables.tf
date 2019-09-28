variable "aws_region" {
    description = "AWS region to launch resources."
    default = "us-east-1" 
}

variable "provider_version" {
    description = "AWS provider version to use"
    default = "~> 2.0"
}

variable "aws_profile" {
    description = "AWS provider credentials in AWS config file"
    default = "default"
}

variable "lambda_policy_name" {
    description = "name of lambda policy"
    default = "lambda_policy_for_lambda_role"
  
}

variable "iam_role_name" {
    description = "name of iam role for lambda"
    default = "lambda_cloudWatch_access"
  
}

variable "iam_role_description" {
    description = "the role/purpose of the iam role created for lambda"
    default = "lambda to access cloudwatch events and sns"
  
}



