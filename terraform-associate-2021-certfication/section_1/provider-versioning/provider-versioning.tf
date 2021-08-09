provider "aws" {
    region = "us-east-1"
    version = ">=3.0"
}

resource aws_instance "terraform-ec2" {
    ami = "ami-0be2609ba883822ec"
    instance_type = "t2.micro"


}