module "notify-slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 2.3.0"

  #Add resource check, if exists don't create
  create = var.aws_notification_slack_enabled
  
  #Turn into a variable
  create_sns_topic     = true
  sns_topic_name       = "${upper(var.environment)}-${var.servicename}-sns"
  lambda_function_name = "${upper(var.environment)}-${var.servicename}-notify-slack"
  slack_webhook_url    = var.aws_notification_slack_webhook_url
  slack_username       = var.aws_notification_slack_username
  slack_channel        = var.aws_notification_slack_channel
  slack_emoji          = var.aws_notification_slack_emoji
  tags                 = local.common_tags


}