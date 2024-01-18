# aks-terraform/main.tf file

terraform{
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.0.0"
        }
    }
}

provider "azurerm" {
    features{}

    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
}

module "networking"{
    source = "./networking-module"
    
    # Input variables for networking module
    resource_group_name = "networkingproject_resource_group"
    location = "UK South"
    vnet_address_space = ["10.0.0.0/16"]
}

# Adding the aks-cluster-module

module "aks-cluster"{
    source = "./aks-cluster-module"

    # Input variables for AKS Cluster module
    aks_cluster_name = "terraform-aks-module"
    cluster_location = "UK South"
    dns_prefix = "myaks-project"
    kubernetes_version = "1.26.6"
    service_principal_client_id = var.client_id
    service_principal_client_secret = var.client_secret

    # Input variables referencign outputs from networking module
    resource_group_name = module.networking.resource_group_name
    vnet_id = module.networking.vnet_id
    control_plane_subnet_id = module.networking.control_plane_subnet_id
    worker_node_subnet_id = module.networking.worker_node_subnet_id
}