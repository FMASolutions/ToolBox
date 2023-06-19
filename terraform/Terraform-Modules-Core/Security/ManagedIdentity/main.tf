resource "azurerm_user_assigned_identity" "uamid_for_each" {
  for_each = var.managed_identities

  location            = each.value.location
  name                = each.key
  resource_group_name = each.value.rg_name
  tags                = local.all_tags
}