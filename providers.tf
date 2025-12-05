# Initialises Terraform providers and sets their version numbers.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.49.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11.0"
    }
    ec = {
      source  = "elastic/ec"
      version = ">= 0.9.0"
    }
  }

  required_version = ">= 1.5.6"
}

provider "azurerm" {
  features {}
}

# Elastic Cloud provider – uses an API key from a variable
provider "ec" {
  apikey = var.ec_api_key
}
