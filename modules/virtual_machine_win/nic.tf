resource "azurerm_network_interface" "vm_nic" {
  for_each            = {for entry in local.nic_mappings : "${entry.instance_name}-${entry.nic_name}" => entry}
  name                = "${each.key}"
  location            = local.location
  resource_group_name = var.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configs
    content {
      name                          = "${each.key}-${ip_configuration.value["name"]}"
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = ip_configuration.value["allocation_type"]
      private_ip_address            = ip_configuration.value["ip"]
      primary                       = ip_configuration.value["primary"]
    }
  }
}