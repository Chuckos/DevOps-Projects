provider "aws" {
  region     = "us-east-1"
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-cluster"
  instance_count         = 1

  ami                    = "ami-0d6621c01e8c2de2c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-4dbfb206"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}