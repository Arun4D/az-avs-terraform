locals {
  instance_disk_mapping = distinct(
    flatten(
      [
        for instance in local.instance_name : [
          for disk in local.data_disk_size : {
            instance_name        = instance
            data_disk_size       = disk
            storage_account_type = "${lookup(local.data_disk_types, upper(substr(disk, 0, 1)), "Standars_LRS")}"
          }
        ]
      ]
    )
  )
  vm_details = azurerm_windows_virtual_machine.windows_vm
}

resource "azurerm_managed_disk" "data_disk" {

  for_each = { for entry in local.instance_disk_mapping : "${entry.instance_name}-${entry.data_disk_size}" => entry }

  zone                 = var.zonal ? tostring((index(local.instance_name, each.value.instance_name) % 3) + 1) : ""
  create_option        = "Empty"
  location             = local.location
  name                 = "${each.value.instance_name}-data-disk${(index(local.data_disk_size, each.value.data_disk_size) % length(local.data_disk_size)) + 1}"
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.storage_account_type
  disk_size_gb         = var.config["disk_size"][local.data_disk_size[index(local.instance_disk_mapping, each.value) % length(local.data_disk_size)]]
  tags                 = local.tags

}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {

  for_each = { for entry in local.instance_disk_mapping : "${entry.instance_name}-${entry.data_disk_size}" => entry }

  caching            = "ReadWrite"
  lun                = 10 + (index(local.instance_disk_mapping, each.value) % length(local.data_disk_size))
  managed_disk_id    = lookup({ for k, v in azurerm_managed_disk.data_disk : v.name => v.id }, "${each.value.instance_name}-data-disk${(index(local.data_disk_size, each.value.data_disk_size) % length(local.data_disk_size)) + 1}")
  virtual_machine_id = lookup({ for k, v in local.vm_details : v.name => v.id }, "${each.value.instance_name}")
}