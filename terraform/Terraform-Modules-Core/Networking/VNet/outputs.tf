output "vnet_address_space" {
  description = "Address space of the V-Net"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_guid" {
  description = "GUID of the V-Net"
  value       = azurerm_virtual_network.vnet.guid
}

output "vnet_id" {
  description = "ID of the V-Net"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_location" {
  description = "Location of the V-Net"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_name" {
  description = "Name of the V-Net"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_subnets" {
  description = "IDs of the subnets created inside the V-Net"
  value       = local.azurerm_subnets[*].id
}

output "vnet_subnets_name_id" {
  description = "Query subnet_id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = local.azurerm_subnets_name_id_map
}