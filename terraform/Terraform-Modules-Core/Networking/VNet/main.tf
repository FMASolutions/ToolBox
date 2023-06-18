resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.vnet_location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = local.all_tags
}

resource "azurerm_subnet" "subnet_for_each" {
  for_each = toset(var.subnet_names)

  address_prefixes     = [local.subnet_names_prefixes[each.value]]
  name                 = each.value
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

locals {
  azurerm_subnets = [for s in azurerm_subnet.subnet_for_each : s]
  azurerm_subnets_name_id_map = {
    for index, subnet in local.azurerm_subnets :
    subnet.name => subnet.id
  }
}