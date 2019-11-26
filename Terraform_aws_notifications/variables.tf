variable "aws_region" {
  description = "AWS region to launch resources."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS provider credentials in AWS config file"
  type        = string
  default     = "default"
}

variable "aws_notification_slack_enabled" {
  description = "Whether to create all aws resources for slack module"
  type        = bool
  default     = true
}

variable "aws_notification_slack_webhook_url" {
  description = "The URL of Slack webhook"
  type        = string
  default     = ""
}

variable "aws_notification_slack_username" {
  description = "The username that will appear on Slack messages"
  type        = string
  default     = "AWS-Notifications"
}

variable "aws_notification_slack_channel" {
  description = "The name of the channel in Slack for notifications"
  type        = string
  default     = "aws_notification_alerts"
}

variable "aws_notification_slack_emoji" {
  description = "A custom emoji that will appear on Slack messages"
  type        = string
  default     = ":aws:"
}

variable "environment" {
  description = "environment name of where the resources have been deployed"
}

variable "servicename" {
  description = "name of the service"
  type        = string
  default     = "aws-notifications"
}

variable "display_name" {
  description = "Name shown in confirmation emails"
  type        = string
  default     = "AWS Health Alerts"
}

variable "email_addresses" {
  description = "Email address to send notifications to"
  type        = string
  default     = ""
}

variable "protocol" {
  description = "SNS Protocol to use.  email or email-json"
  type        = string
  default     = "email"
}

variable "stack_name" {
  description = "Unique Cloudformation stack name that wraps the SNS topic"
  type        = string
  default     = "sns-subscription-stack"
}
