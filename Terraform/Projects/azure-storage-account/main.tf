terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "DemoRG"
    # access_key is set via the `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "tfstate29766"
    container_name       = "tfstate"                                  
    key                  = "terraform.tfstate"                   
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "storage-rgcvf"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "temmystorage1234"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}