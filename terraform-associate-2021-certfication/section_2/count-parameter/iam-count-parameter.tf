provider "aws" {
  region     = "us-west-2"
}

variable "elb_names" {
  type = list
  default = ["dev-loadbalancer", "stage-loadbalanacer","prod-loadbalancer"]
}

resource "aws_iam_user" "lb" {
  name = var.elb_names[count.index]
  count = 3
  path = "/system/"

  tags = {
    "count_name" = var.elb_names[count.index]
  }
}