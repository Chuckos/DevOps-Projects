terraform {
  backend "s3" {
    bucket = "bucket name"
    key    = "terraform-certifcate.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-state-lock"
  }
}
