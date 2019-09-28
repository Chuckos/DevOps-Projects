# Specify the provider and AWS access details
provider "aws" {
  profile = "${var.aws_profile}"
  version = "${var.provider_version}"
  region  = "${var.aws_region}"
}
#-------------------------------
# aws_iam_lambda_role_policy
#-------------------------------

resource "aws_iam_role_policy" "lambda_policy" {
    name = "lambda_charles_policy"
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

#-------------------------------
# aws_iam_lambda_role
#-------------------------------

resource "aws_iam_role" "lambda_cloudWatch_access" {
  name = "lambda_cloudWatch_access"
  description = "lambda to access cloudwatch events and sns"


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
    cost = "evrythng"
    project = "terraform"
  }
}

#-------------------------------
# Lambda Function
#-------------------------------


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


