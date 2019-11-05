# render lambda service policy json template file
data "template_file" "lambda_service_policy" {
  template = "${file("templates/lambda_service_policy.json")}"
}

# render lambda assume role policy
data "template_file" "lambda_assume_role_policy" {
  template = "${file("templates/lambda_assume_role_policy.json")}"
}

# create iam lambda role policy
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "${var.lambda_policy_name}"
  role   = "${aws_iam_role.lambda_cloudWatch_access.id}"
  policy = "${data.template_file.lambda_service_policy.rendered}"


}

# Create lambda role via iam service
resource "aws_iam_role" "lambda_cloudWatch_access" {
  name               = "${var.iam_role_name}"
  description        = "${var.iam_role_description}"
  assume_role_policy = "${data.template_file.lambda_assume_role_policy.rendered}"
  #tags               = local.common_tags
}