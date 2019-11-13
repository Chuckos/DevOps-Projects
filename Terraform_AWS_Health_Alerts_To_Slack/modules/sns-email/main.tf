locals {
  # common tags to be assigned to all resources
  common_tags = {
    Environment = "Production"
    Project     = "aws health alert"
    Owner       = "Charles Adeeko"
  }
}

data "template_file" "cloudformation_sns_subscription" {
  template = file("${path.module}../../../templates/cloudformation_email_subscription_policy.json")

  vars = {

    subscriptions = var.email_addresses
    topic_arn = var.topic_arn
  }
}

resource "aws_cloudformation_stack" "sns_email_subscription" {
  name          = var.stack_name
  template_body = data.template_file.cloudformation_sns_subscription.rendered
  tags          = local.common_tags

}

