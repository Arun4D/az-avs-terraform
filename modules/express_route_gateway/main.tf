

resource "azurerm_virtual_network_gateway" "gateway" {
  name                = var.express_route_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.default_tags

  type = var.express_route_gateway_type
  sku  = var.express_route_gateway_sku

  /*ip_configuration {
    name                          = "default"
    public_ip_address_id          = var.public_ip_id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }*/

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