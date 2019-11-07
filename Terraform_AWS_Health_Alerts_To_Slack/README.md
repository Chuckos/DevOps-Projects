<<<<<<< HEAD
## Terraform AWS Health Alerts
=======
## AWS Provider Terraform Project
>>>>>>> a1ec55853a3e7239393094481b32e572b3b48e83

### Requirements
* Requires terraform version >= 0.12.9 

<<<<<<< HEAD
=======
• CloudWatch events
• Lambda
• SNS
• IAM
>>>>>>> a1ec55853a3e7239393094481b32e572b3b48e83

This project uses various AWS services and slack with Terraform.  The purpose of this project to capture any AWS personal dashboard health alerts and send this information to a designated slack channel.  The AWS services used are the following:

* CloudWatch events
* Lambda
* SNS
* IAM

### Simple Installation
1. Clone this github repository

```
$ git clone git@github.com:Chuckos/infrastructure-as-code.git
$ cd Terraform_AWS_Health_Alerts_To_Slack
```
2. Run `terraform init` to download required providers and modules

3. Run `terraform plan` to create an execution plan to ensure set of changes matches your expectation without making any changes to real resources or to the state.

4. Run `terraform apply` to apply the Terraform configuration and create required infrastructure

### Todo (Refactor Work):
* Add Email module for sns subscription — terraform doesn't support this.
* Add Slack notify Module
* Circle CI pipeline trigger
* <del>Fix common tags to work within module.<del>
* <del>Config file for terraform versioning<del>


To create the resources, clone the repository, set the environment variables, and run `terraform init`, `terraform plan`, then `terraform apply`.
