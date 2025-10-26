terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.47.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
  subscription_id = "b398fea1-2f06-4948-924a-121d4ed265b0"
}