provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "terraform_ec2" {
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"

}

resource "aws_eip" "lb" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.terraform_ec2.id
  allocation_id = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "terraform-security-group"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
    #cidr_blocks = [aws_eip.lb.public_ip/32]
  }

  tags = {
    Name = "terraform-associate-exam"
  }
}