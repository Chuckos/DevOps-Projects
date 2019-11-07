# render sns service delivery policy
data "template_file" "sns_service_delivery_policy" {
  template = file("${path.module}/../templates/sns_service_delivery_policy.json")
}

#provision amazon sns topic
resource "aws_sns_topic" "aws_personal_health_alerts_notification" {
  name            = "aws-personal-health-alerts-topic"
  delivery_policy = data.template_file.sns_service_delivery_policy.rendered
  tags            = local.common_tags
}

# provision aws sns topic subscription
resource "aws_sns_topic_subscription" "user_updates_lambda_target" {
  topic_arn = aws_sns_topic.aws_personal_health_alerts_notification.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.deploy-lambda.arn
}

# allow sns topic to invoke lambda function
resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.deploy-lambda.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.aws_personal_health_alerts_notification.arn
}