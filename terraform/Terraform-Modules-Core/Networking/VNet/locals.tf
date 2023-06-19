locals {
  default_tags = {
    "ManagedBy" = "Terraform"
  }
  all_tags = merge(local.default_tags, var.tags)
}