# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "bobresourcegroup"
    storage_account_name = "bobstorageaccount99"
    container_name = "mybobcontainer"
    key                  = "terraform.tfstate"
  }
  required_version = ">= 1.0.4"
}

provider "azurerm" {
  features {}
}