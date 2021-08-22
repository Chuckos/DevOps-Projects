resource "aws_iam_user" "lb" {
  name = "remoteuser"
  path = "/system/"
}