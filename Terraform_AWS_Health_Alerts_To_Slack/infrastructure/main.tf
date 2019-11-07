locals {
  # common tags to be assigned to all resources
  common_tags = {
    Environment = "Production"
    Project     = "aws health alert"
    Owner       = "Charles Adeeko"
  }
}