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
  subscription_id = "1571dec2-c2bf-474f-b6f3-815ff9d68f68"
  tenant_id       = "578ecb2d-83fa-48c5-9c82-20d5e66e4418"
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