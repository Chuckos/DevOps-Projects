terraform {
  backend "remote" {
    organization = "private-projects"

    workspaces {
      name = "terraform-certifcation-demo"
    }
  }
}