# Specify the provider and AWS access details
provider "aws" {
  profile = "${var.aws_profile}"
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

locals {
  # common tags to be assigned to all resources
  common_tags = {
    Environment = "Production"
    Project     = "aws health alert"
    Owner       = "Charles Adeeko"
  }
}

module "infrastructure" {
  source               = "./infrastructure"
  iam_role_name        = "${var.iam_role_name}"
  iam_role_description = "${var.iam_role_description}"
  lambda_policy_name   = "${var.lambda_policy_name}"

}