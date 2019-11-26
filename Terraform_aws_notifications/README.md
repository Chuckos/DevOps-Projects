## Terraform AWS Health Alerts

### Requirements
* Requires terraform version >= 0.12.9 


This project uses various AWS services and slack with Terraform.  The purpose of this project to capture any AWS personal dashboard health alerts and send this information to a designated slack channel.  The AWS services used are the following:

* CloudWatch
* Lambda
* SNS
* Cloudformation (to add email address to sns topic)

To create the resources, clone the repository, set the environment variables, and run `terraform init`, `terraform plan`, then `terraform apply`.
