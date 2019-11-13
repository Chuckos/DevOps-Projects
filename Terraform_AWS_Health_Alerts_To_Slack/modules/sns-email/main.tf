#data "template_file" "cloudformation_sns_stack" {
 #   template = file("${path.module}../../../templates/email_sns_stack.json")
#}

data "template_file" "cloudformation_sns_subscription" {
  template = file("${path.module}../../../templates/cloudformation_email_subscription_policy.json")

  vars = {
    #display_name  = "${var.display_name}"
    subscriptions = "${var.email_addresses}"
    topic_arn = "${var.topic_arn}"
  }
}

resource "aws_cloudformation_stack" "sns_email_subscription" {
  name          = "${var.stack_name}"
  template_body = "${data.template_file.cloudformation_sns_subscription.rendered}"


}


# refactor to use 0.12 terraform syntax
#resource "aws_cloudformation_stack" "sns_topic" {
 # name          = "${var.stack_name}"
  #template_body = "${data.template_file.cloudformation_sns_stack.rendered}"
  #tags = "${merge(
   # map("Name", "${var.stack_name}")
 # )}"
#}