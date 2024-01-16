
resource "azurerm_vmware_private_cloud" "private_cloud" {
  name                = "vmware-private-cloud"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku_name            = lower(var.avs_sku)

  management_cluster {
    size = var.avs_host_count
  }

  network_subnet_cidr         = var.avs_network_block
  internet_connection_enabled = var.internet_connection_enabled
  nsxt_password               = var.nsxt_password
  vcenter_password            = var.vcenter_password

  timeouts {
    create = "10h"
  }

  lifecycle {
    ignore_changes = [
      nsxt_password,
      vcenter_password
    ]
  }
}

resource "azurerm_vmware_express_route_authorization" "express_route_auth_key" {
  name             = "express-route-auth-key"
  private_cloud_id = azurerm_vmware_private_cloud.private_cloud.id
}