# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location

  tags = local.all_tags
}