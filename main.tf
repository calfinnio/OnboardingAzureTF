module "subscription_calfinn" {
    source = "../tf_module_subscription"
    date = var.date
    ado_project = "CalFinn"
    subscription_name = "CalFinnIO"
    //subscription_alias = "calfinnio"
    subscription_id = "2e9055d2-2f18-47e0-9fdf-0dfe7d73af13"
    owner = "Tim.Alexander@calfinn.io"
    available_to_other_tenants = false
}

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