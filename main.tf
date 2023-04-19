terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "myTFResourceGroup"
    storage_account_name = "tfstatebob"
    container_name       = "tfstatecontainer"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}  
}

variable "location" {
  type = string
  default = "UK South"
}

resource "azurerm_resource_group" "rg" {
  name = "myTFResourceGroup"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstatebob"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"  
}

resource "azurerm_storage_container" "tfstatecontainer" {
  name                  = "tfstatecontainer"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

output "sa_name" {
  value = azurerm_storage_account.tfstate.name
}