provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}


# terraform workspace -h
# terraform workspace show
# terraform workspace new dev
# terraform workspace new prd
# terraform workspace list
# terraform workspace select dev