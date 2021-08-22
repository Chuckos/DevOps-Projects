locals {
  db_password = {
    admin = "password"
  }
}

output "db_password" {
  value = local.db_password
  sensitive   = true
}

# adding sensitive = true makes the output db_password = (sensitive value) and not clear text.