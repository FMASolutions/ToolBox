variable "name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region to deploy to"
  type        = string
  default     = "UK South"
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource group"
  type        = map(any)
  default     = {}
}