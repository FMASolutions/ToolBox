
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

variable "subnets" {
  type = map(string)
}

variable "managed_identities" {
  type = map(object({
    location = string
    rg_name  = string
    role_assignments = map(object({
      scope = string
      role  = string
    }))
  }))
  description = "Managed Identities to create"
}