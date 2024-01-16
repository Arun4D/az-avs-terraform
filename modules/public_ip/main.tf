resource "azurerm_public_ip" "public_ip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku
  tags                = var.default_tags
}
