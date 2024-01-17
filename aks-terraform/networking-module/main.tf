# networking-module main.tf

# Create the Azure Resource Group for networking resources
resource "azurerm_resource_group" "networking" {
    name = var.resource_group_name
    location = var.location
}

# Define the Virtual Network (VNet) for the AKS cluster
resource "azurerm_virtual_network" "aks-vnet"  {
  name ="aks-vnet"
  resource_group_name = azurerm_resource_group.networking.name
  location = azurerm_resource_group.networking.location
  address_space = var.vnet_address_space
}

# Define subnets within the VNet for control plane and worker nodes
resource "azurerm_subnet" "control_plane_subnet"{
  name = "control-plane-subnet"
  resource_group_name = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "worker_node_subnet" {
  name = "worker-node-subnet"
  resource_group_name  = azurerm_resource_group.networking.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes = ["10.0.2.0/24"]
}

# Define Network Security Group (NSG) for the AKS subnet
resource "azurerm_network_security_group" "aks_nsg" {
  name = "aks-nsg"
  location = azurerm_resource_group.networking.location
  resource_group_name = azurerm_resource_group.networking.name
}

# Create inbound rule to allow traffic to kube-apiserver
resource "azurerm_network_security_rule" "kube_apiserver" {
  name                        = "kube-apiserver-rule"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "6443"  # Port used by kube-apiserver
  source_address_prefix       = "92.4.167.52" # Replace with your public IP address
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}

# Allow inbound traffic for SSH (TCP/22) 
resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh-rule"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "92.4.167.52" # Replace with your public IP or IP range
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.networking.name
  network_security_group_name = azurerm_network_security_group.aks_nsg.name
}