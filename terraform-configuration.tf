terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.45.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.35.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.3.0"
    }
  }
}

provider "azuread" {
  # Configuration options
}

provider "azurerm" {
  # Configuration options
  features {}
}

provider "azuredevops" {
  # Configuration options
}


variable "date" {
    type = string
}