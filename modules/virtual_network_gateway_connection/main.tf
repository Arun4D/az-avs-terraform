

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection" {

  location                   = var.location
  name                       = var.network_gateway_name
  resource_group_name        = var.resource_group_name
  type                       = var.network_gateway_type
  virtual_network_gateway_id = var.virtual_network_gateway_id
  express_route_circuit_id   = var.express_route_circuit_id
}