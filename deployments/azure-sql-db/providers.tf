terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    mssql = {
      source = "betr-io/mssql"
      version = "0.2.7"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "mssql" {
  debug = "false"
}