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
  name        = "terraform-repo"
  description = "My awesome codebase"

  visibility = "public"

 
}