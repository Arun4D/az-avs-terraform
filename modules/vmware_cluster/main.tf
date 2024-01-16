
resource "azurerm_vmware_cluster" "vmware_cluster" {
  name               = var.cluster_name
  vmware_cloud_id    = var.vmware_cloud_id
  cluster_node_count = var.cluster_node_count
  sku_name           = lower(var.avs_cluster_sku)
}