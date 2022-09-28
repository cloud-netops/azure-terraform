
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

   backend "azurerm" {
    resource_group_name  = "myResourceGroup"
    storage_account_name = "sureshstorage1080"
    container_name       = "sureshtfstate"
    key                  = "acr.demo.tfstate"
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id ="869080e8-f18e-4ae9-bcb7-f43089c75784"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_container_registry" "acr" {
  name     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Basic"
  admin_enabled            = true
}

output "admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  description = "The object ID of the user"
sensitive = true
}
