# networking-module main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = "069aabee-fed9-4d93-8b03-d24c331f52ad"
  tenant_id       = "47d4542c-f112-47f4-92c7-a838d8a5e8ef"
  skip_provider_registration = "true"
}

module "networking" {
  source = "./aks-terraform/networking-module"
  
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_address_space  = var.vnet_address_space
}

module "aks_cluster" {
  source = "./aks-terraform/aks-cluster-module"

  aks_cluster_name           = "aks-terraform"
  cluster_location           = var.location
  dns_prefix                 = "myaks-project"
  kubernetes_version         = "1.27.7"
  service_principal_client_id = var.client_id
  service_principal_client_secret = var.client_secret
  resource_group_name         = module.networking.networking_resource_group_name
  vnet_id                     = module.networking.vnet_id
  control_plane_subnet_id     = module.networking.control_plane_subnet_id
  worker_node_subnet_id       = module.networking.worker_node_subnet_id
}