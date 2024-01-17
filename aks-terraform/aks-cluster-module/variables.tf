# aks-cluster-module/variables.tf

variable "aks_cluster_name" {
  description = "The name of the AKS cluster you wish to create."
  type        = string
}

variable "cluster_location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix of the cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version the cluster will use."
  type        = string
}

variable "service_principal_client_id" {
  description = "The Client ID for the service principal associated with the cluster."
  type        = string
}

variable "service_principal_client_secret" {
  description = "The Client Secret for the service principal."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the networking resources were provisioned."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the Virtual Network (VNet)."
  type        = string
}

variable "control_plane_subnet_id" {
  description = "The ID of the control plane subnet within the VNet."
  type        = string
}

variable "worker_node_subnet_id" {
  description = "The ID of the worker node subnet within the VNet."
  type        = string
}