terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# Create 3 EC2 for docker swarm example
module "ec2_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 3.0"

    for_each = toset(["manager-1", "worker-1", "worker-2"])

    name = "instance-${each.key}"

    ami = "ami-0c2b8ca1dad447f8a"
    instance_type = "t2.micro"
    key_name = "ec2-login-docker"

    tags = {
        Terraform = "true"
        Environment = "Personal"
        Course = "docker"
    }
}

# Add security group to EC2 Module

# Create 3 EC2 for docker swarm example
# resource "aws_instance" "terraform-ec2" {
#   ami           = "ami-0be2609ba883822ec"
#   instance_type = "t2.micro"
#}