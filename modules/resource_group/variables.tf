variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = ""
  description = "Resource group name."
}


variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}