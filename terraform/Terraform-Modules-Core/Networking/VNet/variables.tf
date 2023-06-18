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


variable "subnet_names" {
  type        = list(string)
  description = "A list of public subnets inside the vnet."
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "The address prefix to use for the subnet."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags to associate with your network and subnets."
}

