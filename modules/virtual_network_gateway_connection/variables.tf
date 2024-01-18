#################################################################
# module variables
#################################################################
variable "network_gateway_name" {
  type = string
}

variable "network_gateway_type" {
  type    = string
  default = "ExpressRoute"
}
variable "virtual_network_gateway_id" {}
variable "express_route_circuit_id" {}

variable "location" {}
variable "resource_group_name" {}

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}