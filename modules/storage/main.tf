# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.prefix}storageaccount"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  network_rules {
    bypass                     = var.network_rules_bypass
    default_action             = var.network_rules_default_action
    ip_rules                   = var.allowed_ip_range
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

  tags = var.default_tags
}