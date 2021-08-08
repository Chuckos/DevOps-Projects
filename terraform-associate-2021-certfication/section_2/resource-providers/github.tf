terraform {
  required_providers {
      github = {
          source = "integrations/github"
          version = "4.3.2"
      }
  }
}

variable "GITHUB_PERSONAL_TOKEN" {
    type = string
}

provider "github" {
    token = var.GITHUB_PERSONAL_TOKEN
}

resource "github_repository" "example" {
  name        = "terraform-repo-example"
  description = "My awesome codebase"

  visibility = "private"

  template {
    owner      = "github"
    repository = "terraform-module-template"
  }
}