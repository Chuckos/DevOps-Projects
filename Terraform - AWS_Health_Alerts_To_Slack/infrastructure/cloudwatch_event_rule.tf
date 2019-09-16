# Configure the AWS Provider
provider "aws" {
  profile = "default"
  version = "~> 2.0"
  region  = "us-east-1"
}

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