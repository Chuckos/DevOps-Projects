# Specify the provider and AWS access details
provider "aws" {
  profile = var.aws_profile
  version = "~> 2.0"
  region  = var.aws_region
}

module "infrastructure" {
  source               = "./modules/infrastructure"
  iam_role_name        = var.iam_role_name
  iam_role_description = var.iam_role_description
  lambda_policy_name   = var.lambda_policy_name
}

module "sns-email-topic" {
  source          = "./modules/sns-email"
  display_name    = "AWS Health Alerts"
  email_addresses = "example@email.com"
  stack_name      = "sns-subscription-stack"
  topic_arn       = module.infrastructure.arn-aws-health-topic

}


