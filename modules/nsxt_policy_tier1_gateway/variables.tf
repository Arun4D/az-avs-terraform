#################################################################
# module variables
#################################################################
variable "express_route_circuit_name" {
  type = string
}
variable "express_route_circuit_sku_tier" {
  type = string
}

variable "express_route_circuit_sku_family" {
  type = string
}
variable "service_provider_name" {}
variable "peering_location" {}
variable "bandwidth_in_mbps" {}
variable "location" {}
variable "resource_group_name" {}

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}