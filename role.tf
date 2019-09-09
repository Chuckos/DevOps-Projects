# Configure the AWS Provider
provider "aws" {
  profile = "default"
  version = "~> 2.0"
  region  = "us-east-1"
}


#-------------------------------

# Role

resource "aws_iam_role" "lambda_cloudWatch_access" {
  name = "lambda_cloudWatch_access",
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