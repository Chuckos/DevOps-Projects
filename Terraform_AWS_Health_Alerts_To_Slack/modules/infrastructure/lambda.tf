# Specify the provider to archive lambda function
provider "archive" {}

# Archive the lambda function
data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_aws_health_check_function.js"
  output_path = "${path.module}/lambda/lambda_aws_health_check_function.zip"
}

# Provision lambda function
resource "aws_lambda_function" "deploy-lambda" {
  filename         = "${path.module}/lambda/lambda_aws_health_check_function.zip"
  function_name    = "health-check-sns-to-slack-test"
  role             =  aws_iam_role.lambda_cloudWatch_access.arn
  handler          = "lambda_aws_health_check_function.handler"
  source_code_hash = data.archive_file.lambda_archive.output_base64sha256
  runtime          = "nodejs10.x"
  tags             = local.common_tags
}