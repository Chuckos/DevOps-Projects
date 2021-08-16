provider "aws" {
  region = "us-east-1"
}

module "ec2module" {
  source = "../ec2-modules/"
  instance_type = "t2.nano"
}