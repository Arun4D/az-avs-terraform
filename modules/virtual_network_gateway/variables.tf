#################################################################
# module variables
#################################################################


variable "vpn_gateway_name" {
  type        = string
  description = "Azure resource name assigned to the AVS vpn gateway instance"
}
variable "vpn_gateway_sku" {
  type        = string
  description = "The sku for the AVS vpn gateway"
  default     = "VpnGw2"
}

variable "asn" {
  type        = number
  description = "The ASN for bgp on the VPN gateway"
  default     = "65515"
}
variable "vpn_gateway_type" { default = "Vpn" }
variable "vpn_gateway_vpn_type" { default = "RouteBased" }
variable "vpn_gateway_generation" { default = "Generation2" }
variable "vpn_gateway_active_active" { default = true }
variable "vpn_gateway_enable_bgp" { default = true }

variable "ip_configurations" {}
variable "location" {}
variable "resource_group_name" {}

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}
