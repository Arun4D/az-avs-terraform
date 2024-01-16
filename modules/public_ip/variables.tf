#################################################################
# module variables
#################################################################
variable "pip_name" {}
variable "pip_allocation_method" { default = "Dynamic" }
variable "pip_sku" { default = "Basic" }
variable "location" {}
variable "resource_group_name" {}

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}