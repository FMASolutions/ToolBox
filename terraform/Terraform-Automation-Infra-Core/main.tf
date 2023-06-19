module "ss-uks-automation-release-rg" {
  source = "../Terraform-Modules-Core/Common/AzResourceGroup"

  name = var.rg_name
  tags = {
    Environment   = var.environment_name
    CostCenter    = "ABC"
    ResourceOwner = "Faisal Ahmed"
    Project       = "Shared Services Automation Release"
  }
}

module "ss-uks-automation-release-vnet" {
  source              = "../Terraform-Modules-Core/Networking/VNet"
  resource_group_name = module.ss-uks-automation-release-rg.name
  vnet_location       = module.ss-uks-automation-release-rg.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags = {
    Environment   = var.environment_name
    CostCenter    = "ABC"
    ResourceOwner = "Faisal Ahmed"
    Project       = "Shared Services Automation Release"
  }
}

#module "ss-uks-automation-release-uamids" {
#  source = "../Terraform-Modules-Core/Security/ManagedIdentity"
#  managed_identities = var.managed_identities
#  identity_tags = {
#    Environment = var.environment_name
#    CostCenter = "ABC"
#    ResourceOwner = "Faisal Ahmed"
#    Project = "Shared Services Release Automation"
#  }
#}