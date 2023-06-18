terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.61.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "ssuksautomationreleasesa"
    container_name       = "terraform-state-container"
    key                  = "AutomationInfraCore.tfstate"
  }
}