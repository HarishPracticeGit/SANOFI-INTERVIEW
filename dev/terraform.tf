# terraform and azure providers
terraform {
    
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            
        }
    }
    backend "azurerm" {
        key = "app.terraform.tfstate"
    }
}



provider "azurerm" {
  features {}
}