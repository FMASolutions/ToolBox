variable "managed_identities" {
    type = map(object({
        location = string
        rg_name = string
        tags = map(string)
    }))
    description = "The user assigned managed identity objects to creates"
}