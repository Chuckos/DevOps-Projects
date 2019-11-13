output "lambda-role-policy" {
  value = aws_iam_role_policy.lambda_policy.id
}

output "lambda-role" {
  value = aws_iam_role.lambda_cloudWatch_access.arn
}

output "arn-aws-health-topic"{
  value = aws_sns_topic.aws_personal_health_alerts_notification.id
}
