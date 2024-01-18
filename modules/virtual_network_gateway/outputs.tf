output "vpn_gateway_id" {
  value = azurerm_virtual_network_gateway.virtual_network_gateway.id
}


output "vpn_gateway_asn" {
  value = azurerm_virtual_network_gateway.virtual_network_gateway.bgp_settings[0].asn
}

/*
output "vpn_gateway_bgp_peering_addresses" {
  value = concat(azurerm_virtual_network_gateway.virtual_network_gateway.bgp_settings[0].peering_addresses[0].default_addresses, azurerm_virtual_network_gateway.gateway.bgp_settings[0].peering_addresses[1].default_addresses)
}
*/
