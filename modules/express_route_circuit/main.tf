resource "azurerm_express_route_circuit" "express_route_circuit" {

  location              = var.location
  name                  = var.express_route_circuit_name
  resource_group_name   = var.resource_group_name
  service_provider_name = var.service_provider_name
  peering_location      = var.peering_location
  bandwidth_in_mbps     = var.bandwidth_in_mbps

  sku {
    tier   = var.express_route_circuit_sku_tier
    family = var.express_route_circuit_sku_family
  }
}