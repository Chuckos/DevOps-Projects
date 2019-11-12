output "arn" {
    description = "Email SNS topic ARN"
    value = "${aws_cloudformation_stack.sns_topic.outputs["ARN"]}"
}
    