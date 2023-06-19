variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to be imported."
  nullable    = false
}

variable "vnet_location" {
  type        = string
  description = "The location of the vnet to create."
  nullable    = false
}

variable "vnet_name" {
  type        = string
  description = "Name of the vnet to create"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
}

# Defaults to Azure DNS if no value provided
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used inside the vnet. Defaults to Azure DNS if no value provided"
}

variable "ddos_protection_plan" {
  type = object({
    enable = bool
    id     = string
  })
  default     = null
  description = "DDoS protection plan configuration"
}

variable "subnets" {
  type        = map(string)
  description = "Map of subnets to create inside the vnet."
}

variable "subnet_private_endpoint_network_policies_enabled" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private endpoint network policies on the subnet."
}

variable "subnet_private_link_service_network_policies_enabled" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
}

variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "Map of subnet name to service endpoints to add to the subnet."
}

variable "subnet_delegation" {
  type        = map(map(any))
  default     = {}
  description = "Map of subnet name to delegation block on the subnet"
}

variable "nsg_ids" {
  type = map(string)
  default = {
  }
  description = "A map of subnet name to Network Security Group IDs"
}

variable "route_tables_ids" {
  type        = map(string)
  default     = {}
  description = "A map of subnet name to Route table ids"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags to associate with your network and subnets."
}

