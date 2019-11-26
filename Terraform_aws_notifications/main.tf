# Specify the provider and AWS access details
provider "aws" {
  profile = var.aws_profile
  version = "~> 2.0"
  region  = var.aws_region
}

module "infrastructure" {
  source                             = "./infrastructure"
  environment                        = "${upper(var.environment)}"
  servicename                        = var.servicename
  aws_notification_slack_enabled     = var.aws_notification_slack_enabled
  aws_notification_slack_webhook_url = var.aws_notification_slack_webhook_url
  aws_notification_slack_username    = var.aws_notification_slack_username
  aws_notification_slack_channel     = var.aws_notification_slack_channel
  aws_notification_slack_emoji       = var.aws_notification_slack_emoji
  display_name                       = var.display_name
  email_addresses                    = var.email_addresses
  stack_name                         = var.stack_name
  protocol                           = var.protocol

}




