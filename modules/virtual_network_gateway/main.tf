
resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = var.vpn_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  type       = var.vpn_gateway_type
  vpn_type   = var.vpn_gateway_vpn_type
  sku        = var.vpn_gateway_sku
  generation = var.vpn_gateway_generation

  active_active = var.vpn_gateway_active_active
  enable_bgp    = var.vpn_gateway_enable_bgp

  bgp_settings {
    asn = var.asn
  }


  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = ip_configuration.value["name"]
      public_ip_address_id          = ip_configuration.value["public_ip_address_id"]
      private_ip_address_allocation = ip_configuration.value["private_ip_address_allocation"]
      subnet_id                     = ip_configuration.value["subnet_id"]
    }
  }

}
