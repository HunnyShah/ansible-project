provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"  # Use a single version across all files
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
  }
}

provider "random" {}

# Keep backend state configuration, but remove duplicate resource groups
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstaten01514804unique12"  # Ensure uniqueness
  resource_group_name      = "n01514804-RG"
  location                 = "Canada Central"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
