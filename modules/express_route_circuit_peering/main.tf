resource "azurerm_express_route_circuit_peering" "express_route_peering" {

  express_route_circuit_name    = var.express_route_circuit_name
  peering_type                  = var.express_route_peering_type
  resource_group_name           = var.resource_group_name
  vlan_id                       = var.vlan_id
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix

}