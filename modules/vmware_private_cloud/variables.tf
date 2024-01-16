variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = ""
  description = "Resource group name."
}

variable "avs_sku" {}

variable "avs_host_count" {}

variable "avs_network_block" {}

variable "nsxt_password" {}

variable "vcenter_password" {}

variable "internet_connection_enabled" { default = false }

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}