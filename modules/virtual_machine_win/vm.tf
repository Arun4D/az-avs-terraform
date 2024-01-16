locals {
  nic_result_values       = { for k, v in azurerm_network_interface.vm_nic : v.name => v.id }
  storage_os_disk_size_gb = var.config["disk_size"][local.os_disk_size]
  publisher               = var.config["image"][local.image]["publisher"]
  offer                   = var.config["image"][local.image]["offer"]
  sku                     = var.config["image"][local.image]["sku"]
  version                 = var.config["image"][local.image]["version"]
}
resource "azurerm_windows_virtual_machine" "windows_vm" {

  for_each              = toset(local.instance_name)
  name                  = each.key
  location              = local.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = values({ for k, v in local.nic_result_values : k => v if startswith(k, each.key) })
  size                  = local.vm_size[index(local.instance_name, each.key) % length(local.vm_size)]

  license_type               = local.license_type
  encryption_at_host_enabled = true

  admin_username = var.admin_username
  admin_password = var.admin_password
  computer_name  = each.key

  # Not enabled for student subscription
  # encryption_at_host_enabled = true
  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = local.os_managed_disk_type
    disk_size_gb         = local.storage_os_disk_size_gb

    #disk_encryption_set_id = var.disk_encryption_set_id
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }
  provision_vm_agent = var.provision_vm_agent

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = var.user_assigned_identity
  }

  tags = var.default_tags

  depends_on = [azurerm_network_interface.vm_nic]
}


