# Specify the provider and AWS access details
provider "aws" {
  profile = "${var.aws_profile}"
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

# Specify the provider to archive lambda function
provider "archive" {}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_aws_health_check_function.js"
  output_path = "${path.module}/lambda/lambda_aws_health_check_function.zip"
}

# create iam lambda role policy
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.lambda_policy_name}"
  role = "${aws_iam_role.lambda_cloudWatch_access.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# Create lambda role via iam service
resource "aws_iam_role" "lambda_cloudWatch_access" {
  name        = "${var.iam_role_name}"
  description = "${var.iam_role_description}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    cost    = "evrythng"
    project = "aws-health-alert"
  }
}

# Provision lambda function
resource "aws_lambda_function" "deploy-lambda" {
  filename      = "${path.module}/lambda/lambda_aws_health_check_function.zip"
  function_name = "health-check-sns-to-slack-test"
  role          = "${aws_iam_role.lambda_cloudWatch_access.arn}"
  handler       = "exports.test"

  # source_code_hash = "${filebase64sha256("lambda_function_payload.zip")}"
  source_code_hash = "${data.archive_file.lambda_archive.output_base64sha256}"
  runtime          = "nodejs10.x"
}

#-------------------------------
# aws_cloudwatch event rule
#-------------------------------
resource "aws_cloudwatch_event_rule" "service_health_dashboard" {
  name        = "capture-aws-service-health-alerts"
  description = "Rule created to pick up any AWS personal health reports and then send to an email group via SNS topic"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.health"
  ]
}
PATTERN
}
