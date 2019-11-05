variable "iam_role_name" {
  description = "name of iam role for lambda"
  type        = string
}

variable "iam_role_description" {
  description = "the role/purpose of the iam role created for lambda"
  type        = string
}

variable "lambda_policy_name" {
  description = "name of lambda policy"
  type        = string
}