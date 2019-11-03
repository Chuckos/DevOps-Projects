# Specify the provider and AWS access details
provider "aws" {
  profile = "${var.aws_profile}"
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

# Specify the provider to archive lambda function
provider "archive" {}

# Archive the lambda function
data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_aws_health_check_function.js"
  output_path = "${path.module}/lambda/lambda_aws_health_check_function.zip"
}
# render lambda service policy json template file
data "template_file" "lambda_service_policy" {
  template = "${file("${path.module}/templates/lambda_service_policy.json")}"
}

# render lambda assume role policy
data "template_file" "lambda_assume_role_policy" {
  template = "${file("${path.module}/templates/lambda_assume_role_policy.json")}"
}

# render sns service delivery policy
data "template_file" "sns_service_delivery_policy" {
  template = "${file("${path.module}/templates/sns_service_delivery_policy.json")}"
}

# render cloudwatch event pattern
data "template_file" "service_health_dashboard_cloudwatch_event_pattern" {
  template = "${file("${path.module}/templates/service_health_dashboard_cloudwatch_event_pattern.json")}"
}

locals {
  # common tags to be assigned to all resources
  common_tags = {
    Environment = "Production"
    Project    = "aws health alert"
    Owner      = "Charles Adeeko"
  }
}

# create iam lambda role policy
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "${var.lambda_policy_name}"
  role   = "${aws_iam_role.lambda_cloudWatch_access.id}"
  policy = "${data.template_file.lambda_service_policy.rendered}"


}

# Create lambda role via iam service
resource "aws_iam_role" "lambda_cloudWatch_access" {
  name               = "${var.iam_role_name}"
  description        = "${var.iam_role_description}"
  assume_role_policy = "${data.template_file.lambda_assume_role_policy.rendered}"
  tags               = local.common_tags
}

# Provision lambda function
resource "aws_lambda_function" "deploy-lambda" {
  filename         = "${path.module}/lambda/lambda_aws_health_check_function.zip"
  function_name    = "health-check-sns-to-slack-test"
  role             = "${aws_iam_role.lambda_cloudWatch_access.arn}"
  handler          = "lambda_aws_health_check_function.handler"
  source_code_hash = "${data.archive_file.lambda_archive.output_base64sha256}"
  runtime          = "nodejs10.x"
  tags             = local.common_tags
}

# allow sns topic to invoke lambda function
resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.deploy-lambda.arn}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.aws_personal_health_alerts_notification.arn}"
}


#provision amazon sns topic
resource "aws_sns_topic" "aws_personal_health_alerts_notification" {
  name            = "aws-personal-health-alerts-topic"
  delivery_policy = "${data.template_file.sns_service_delivery_policy.rendered}"
  tags            = local.common_tags
}

# provision aws sns topic subscription
resource "aws_sns_topic_subscription" "user_updates_lambda_target" {
  topic_arn = "${aws_sns_topic.aws_personal_health_alerts_notification.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.deploy-lambda.arn}"
}


# Provision aws cloudwatch event rule with sns topic target
resource "aws_cloudwatch_event_rule" "service_health_dashboard" {
  name          = "AWS-health-Alerts"
  description   = "Rule created to pick up any AWS personal health reports and then send to a slack channel via SNS topic and lambda function"
  event_pattern = "${data.template_file.service_health_dashboard_cloudwatch_event_pattern.rendered}"
  tags          = local.common_tags
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = "${aws_cloudwatch_event_rule.service_health_dashboard.name}"
  target_id = "SendToSNS"
  arn       = "${aws_sns_topic.aws_personal_health_alerts_notification.arn}"
}