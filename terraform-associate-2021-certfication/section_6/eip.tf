resource "aws_eip" "myeip" {
  vpc = "true"
}

resource "aws_eip" "myeip01" {
  vpc = "true"
  provider = "aws.aws02"
}

# 1st EIP -- one region
# 2nd EIP -- second region