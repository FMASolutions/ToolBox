variable "managed_identities" {
  type = map(object({
    location = string
    rg_name  = string
  }))
  description = "The user assigned managed identity objects to creates"
}

variable "identity_tags" {
  type        = map(string)
  description = "The tags to associate with all managed identities"
}