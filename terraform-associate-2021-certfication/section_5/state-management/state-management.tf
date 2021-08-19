provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"
}

terraform {
  backend "s3" {
    bucket = "{{bucket-name}}"
    key    = "terraform-certifcate.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-state-lock"
  }
}