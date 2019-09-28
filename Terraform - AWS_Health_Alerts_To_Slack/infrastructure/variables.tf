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

