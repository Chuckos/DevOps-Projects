# render cloudwatch event pattern
data "template_file" "service_health_dashboard_cloudwatch_event_pattern" {
  template = file("templates/service_health_dashboard_cloudwatch_event_pattern.json")
}

# Provision aws cloudwatch event rule for service health dashboard
resource "aws_cloudwatch_event_rule" "service_health_dashboard" {
  name          = "${upper(var.environment)}-${var.servicename}-event-rule"
  description   = "Rule created to pick up any AWS personal health reports and then send to a slack channel via SNS topic and lambda function"
  event_pattern = data.template_file.service_health_dashboard_cloudwatch_event_pattern.rendered
  tags          = local.common_tags
}

# Provision cloudwatch event target to sns topic
resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.service_health_dashboard.name
  target_id = "SendToSNS"
  arn       = module.notify-slack.this_slack_topic_arn
}