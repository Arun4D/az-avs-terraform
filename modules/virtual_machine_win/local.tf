locals {
  location       = var.config["location"]
  instance_name  = var.config["virtual_machine"][var.environment][var.application]["instance_name"]
  instance_count = var.config["virtual_machine"][var.environment][var.application]["instance_count"]
  image = var.config["virtual_machine"][var.environment][var.application]["image"]
  ip_address     = var.config["virtual_machine"][var.environment][var.application]["ip_address"]
  has_public_ip  = var.config["virtual_machine"][var.environment][var.application]["has_public_ip"]
  vm_size        = var.config["virtual_machine"][var.environment][var.application]["vm_size"]
  os_disk_size   = var.config["virtual_machine"][var.environment][var.application]["os_disk_size"]
  data_disk_size = var.config["virtual_machine"][var.environment][var.application]["data_disk_size"]
  license_type   = var.config["virtual_machine"][var.environment][var.application]["license_type"]
  os_type        = var.config["virtual_machine"][var.environment][var.application]["os_type"]
  data_disk_types = var.config["data_disk_types"]
  tags           = var.default_tags

  os_managed_disk_type = "${lookup(local.data_disk_types, upper(substr(local.os_disk_size, 0, 1)), (contains(["prd"], var.environment ) ? "Premium_LRS" : "Standard_LRS") )}"

  nic_mappings = distinct(
    flatten([
      for ip_array_index, ip_array in local.ip_address : [
        for nic_index, nics in ip_array : {
          instance_name = "${local.instance_name[ip_array_index]}"
          nic_name      = nics.nic_name
          ip_configs    = nics.ip_configs
        }
      ]
    ])
  )
}