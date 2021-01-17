provider "aws" {
    region = "us-east-1"
  
}

resource "aws_eip" "lb" {
  vpc      = true
}



output "eip" {
    value = aws_eip.lb
}

resource "aws_s3_bucket" "mys3" {
  bucket = "my-tf-test-bucket-2021"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "mys3bucket" {
    value = aws_s3_bucket.mys3
  
}
