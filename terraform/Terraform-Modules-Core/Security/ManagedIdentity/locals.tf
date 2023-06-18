locals {
  subnet_names_prefixes = zipmap(var.subnet_names, var.subnet_prefixes)
  default_tags = {
    "ManagedBy" = "Terraform"
  }
  all_tags = merge(local.default_tags, var.tags)
}