# Specify the provider and AWS access details
provider "aws" {
  profile = "${var.aws_profile}"
  version = "~> 2.0"
  region  = "${var.aws_region}"
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
  name = "${var.iam_role_name}"
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
    cost = "evrythng"
    project = "aws-health-alert"
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


