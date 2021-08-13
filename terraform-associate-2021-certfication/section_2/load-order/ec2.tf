resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}

### iam_user.tf

resource "aws_instance" "newec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}