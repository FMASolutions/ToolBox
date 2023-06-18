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
  subnet_names        = var.subnet_names
  subnet_prefixes     = var.subnet_prefixes
  tags = {
    Environment   = var.environment_name
    CostCenter    = "ABC"
    ResourceOwner = "Faisal Ahmed"
    Project       = "Shared Services Automation Release"
  }
}