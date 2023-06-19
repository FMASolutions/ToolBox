resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.vnet_location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = local.all_tags
  dynamic "ddos_protection_plan" { 
    for_each = var.ddos_protection_plan != null ? [var.ddos_protection_plan] : []

    content {
      enable = ddos_protection_plan.value.enable
      id     = ddos_protection_plan.value.id
    }
  }
}

resource "azurerm_subnet" "subnet_for_each" {
  for_each = var.subnets
  address_prefixes     = [each.value]
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = lookup(var.subnet_private_endpoint_network_policies_enabled, each.key, false)
  private_link_service_network_policies_enabled  = lookup(var.subnet_private_link_service_network_policies_enabled, each.key, false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, each.key, null)

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, each.key, {})

    content {
      name = delegation.key

      service_delegation {
        name    = lookup(delegation.value, "service_name")
        actions = lookup(delegation.value, "service_actions", [])
      }
    }
  }
}

locals {
  azurerm_subnets = [for s in azurerm_subnet.subnet_for_each : s]
  azurerm_subnets_name_id_map = {
    for index, subnet in local.azurerm_subnets :
    subnet.name => subnet.id
  }
}

resource "azurerm_subnet_network_security_group_association" "vnet" {
  for_each = var.nsg_ids

  network_security_group_id = each.value
  subnet_id                 = local.azurerm_subnets_name_id_map[each.key]
}

resource "azurerm_subnet_route_table_association" "vnet" {
  for_each = var.route_tables_ids

  route_table_id = each.value
  subnet_id      = local.azurerm_subnets_name_id_map[each.key]
}