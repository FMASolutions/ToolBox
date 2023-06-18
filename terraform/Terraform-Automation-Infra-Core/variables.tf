
variable "environment_name" {
  type        = string
  description = "Environment name (e.g Production / Develpment / Test / Stage)"
}

variable "rg_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the vnet"
}

variable "address_space" {
  type        = list(string)
  description = "Address space to use for the vnet."
}

variable "subnet_names" {
  type        = list(string)
  description = "List of names for the subnets inside the vnet."
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Address prefix to use for the subnet."
}