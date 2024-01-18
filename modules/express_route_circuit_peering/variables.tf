#################################################################
# module variables
#################################################################
variable "express_route_circuit_name" {
  type = string
}
variable "express_route_peering_type" {
  type = string
}
variable "vlan_id" {}
variable "location" {}
variable "resource_group_name" {}
variable "primary_peer_address_prefix" {}
variable "secondary_peer_address_prefix" {}

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}