#################################################################
# module variables
#################################################################
variable "express_route_gateway_name" {
  type        = string
  description = "Azure resource name assigned to the AVS expressroute gateway instance"
}
variable "express_route_gateway_sku" {
  type        = string
  description = "The sku for the AVS expressroute gateway"
  default     = "Standard"
}

variable "express_route_gateway_type" {
  type        = string
  description = "The type for the AVS expressroute gateway"
  default     = "ExpressRoute"
}
variable "ip_configurations" {}
variable "location" {}
variable "resource_group_name" {}

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}