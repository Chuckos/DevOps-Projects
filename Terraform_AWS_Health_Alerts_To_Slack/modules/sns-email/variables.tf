variable "display_name" {
    description = "Name shown in confirmation emails"
    type = "string"
}

variable "email_addresses" {
    description = "Email address to send notifications to"
    type = "list"
}

variable "protocol" {
    description = "SNS Protocol to use.  email or email-json"
    type = "string"
    default = "email"
}

variable "stack_name" {
    description = "Unique Cloudformation stack name that wraps the SNS topic"
    type = "string"
}
