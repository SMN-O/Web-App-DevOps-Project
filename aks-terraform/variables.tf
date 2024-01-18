variable "client_id" {
  description = "The Client ID for the service principal."
  type        = string
}

variable "client_secret" {
  description = "The Client Secret for the service principal."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group."
  type        = string
  default     = "networking-resource-group"
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
  default     = "UK South"
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network (VNet)."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}