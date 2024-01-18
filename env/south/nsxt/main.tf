module "resource_group" {
  source = "../../../modules/resource_group"

  for_each                = { for k, v in var.config["resource_group"] : k => v }
  resource_group_name     = each.value
  resource_group_location = var.config["location"]
  default_tags            = local.global_plus_env_tag
}

module "vmware_private_cloud" {
  source = "../../../modules/vmware_private_cloud"

  avs_sku                     = var.config["avs"]["avs_sku"]
  avs_host_count              = var.config["avs"]["avs_host_count"]
  avs_network_block           = var.config["avs"]["avs_network_block"]
  nsxt_password               = var.config["avs"]["nsxt_password"]
  vcenter_password            = var.config["avs"]["vcenter_password"]
  internet_connection_enabled = var.config["avs"]["internet_connection_enabled"]
  resource_group_name         = var.config["resource_group"]["pvc"]
  resource_group_location     = var.config["location"]
  default_tags                = local.global_plus_env_tag
  depends_on                  = [module.resource_group]
}

module "vmware_cluster" {
  source = "../../../modules/vmware_cluster"

  for_each           = var.config["avs"]["cluster"]
  cluster_name       = each.key
  avs_cluster_sku    = each.value["avs_cluster_sku"]
  cluster_node_count = each.value["cluster_node_count"]
  vmware_cloud_id    = module.vmware_private_cloud.private_cloud_id
  depends_on         = [module.vmware_private_cloud]
}

module "virtual-network" {
  source = "../../../modules/virtual-network"

  vnet_name               = var.config["vnet"]["name"]
  address_space           = var.config["vnet"]["address_space"]
  resource_group_name     = var.config["resource_group"]["pvc"]
  resource_group_location = var.config["location"]
  default_tags            = local.global_plus_env_tag
  depends_on              = [module.resource_group]
}

module "subnet" {
  source = "../../../modules/subnet"

  for_each             = var.config["subnet"]
  subnet_name          = "${each.key}-snet"
  resource_group_name  = var.config["resource_group"]["nw"]
  address_prefixes     = each.value
  virtual_network_name = module.virtual-network.vnet_name
  depends_on           = [module.virtual-network, module.resource_group]

}

module "user-assigned-identity" {
  source              = "../../../modules/user_assigned_identity"
  config              = local.config_final
  resource_group_name = var.config["resource_group"]["pvc"]
  depends_on          = [module.resource_group]
}

module "storage" {
  source = "../../../modules/storage"

  prefix                     = "diag"
  allowed_ip_range           = []
  default_tags               = local.global_plus_env_tag
  location                   = var.config["location"]
  resource_group_name        = var.config["resource_group"]["pvc"]
  virtual_network_subnet_ids = values({ for k, v in module.subnet : v.subnet_name => v.subnet_id })
  depends_on                 = [module.resource_group, module.subnet]
}

module "windows-vm" {

  source = "../../../modules/virtual_machine_win"

  admin_password                       = "admin01"
  admin_username                       = "P@ssw0rd@134"
  environment                          = "dev"
  application                          = "jump-box"
  boot_diagnostics_storage_account_uri = module.storage.primary_blob_endpoint
  config                               = local.config_final
  default_tags                         = local.global_plus_env_tag
  # Placeholder for disk encryption.
  disk_encryption_set_id = ""
  provision_vm_agent     = true
  resource_group_name    = var.config["resource_group"]["pvc"]
  subnet_id = lookup({
    for k, v in module.subnet : v.subnet_name => v.subnet_id
  }, "jump-box-snet")
  user_assigned_identity = [module.user-assigned-identity.user_assigned_identity_id]

  depends_on = [module.user-assigned-identity, module.storage]
}

module "express_route_gateway_public_ip" {
  source = "../../../modules/public_ip"

  pip_name            = "public-ip"
  pip_sku             = "Basic"
  location            = var.config["location"]
  resource_group_name = var.config["resource_group"]["pvc"]
  default_tags        = local.global_plus_env_tag

  depends_on = [module.resource_group]
}

module "express_route_circuit" {
  source = "../../../modules/express_route_circuit"

  express_route_circuit_name       = var.config["network"]["express_route_circuit"]["name"]
  service_provider_name            = var.config["network"]["express_route_circuit"]["service_provider_name"]
  peering_location                 = var.config["network"]["express_route_circuit"]["peering_location"]
  bandwidth_in_mbps                = var.config["network"]["express_route_circuit"]["bandwidth_in_mbps"]
  express_route_circuit_sku_family = var.config["network"]["express_route_circuit"]["sku"]["family"]
  express_route_circuit_sku_tier   = var.config["network"]["express_route_circuit"]["sku"]["tier"]
  location                         = var.config["location"]
  resource_group_name              = var.config["resource_group"]["pvc"]
  default_tags                     = local.global_plus_env_tag

  depends_on = [module.resource_group]
}

module "express_route_circuit_peering" {
  source = "../../../modules/express_route_circuit_peering"

  express_route_circuit_name    = module.express_route_circuit.express_route_circuit_name
  express_route_peering_type    = var.config["network"]["peering"]["peering_type"]
  primary_peer_address_prefix   = var.config["network"]["peering"]["primary_peer_address_prefix"]
  secondary_peer_address_prefix = var.config["network"]["peering"]["secondary_peer_address_prefix"]
  vlan_id                       = var.config["network"]["peering"]["vlan_id"]
  location                      = var.config["location"]
  resource_group_name           = var.config["resource_group"]["pvc"]
  default_tags                  = local.global_plus_env_tag

  depends_on = [module.resource_group, module.express_route_circuit]
}

module "virtual_network_gateway" {
  source = "../../../modules/virtual_network_gateway"

  vpn_gateway_name          = var.config["network"]["virtual_network_gateway"]["name"]
  vpn_gateway_sku           = var.config["network"]["virtual_network_gateway"]["sku"]
  asn                       = var.config["network"]["virtual_network_gateway"]["asn"]
  vpn_gateway_active_active = var.config["network"]["virtual_network_gateway"]["active_active"]
  vpn_gateway_enable_bgp    = var.config["network"]["virtual_network_gateway"]["enable_bgp"]

  ip_configurations = [
    {
      name                          = "VPN_Gateway_PIP_1"
      public_ip_address_id          = module.express_route_gateway_public_ip.public_ip_id
      private_ip_address_allocation = "Dynamic"
      subnet_id = lookup({
        for k, v in module.subnet : v.subnet_name => v.subnet_id
      }, "jump-box-snet")
    }
  ]
  location            = var.config["location"]
  resource_group_name = var.config["resource_group"]["pvc"]
  default_tags        = local.global_plus_env_tag

  depends_on = [module.resource_group, module.subnet, module.express_route_gateway_public_ip]

}


module "express_route_gateway" {
  source = "../../../modules/express_route_gateway"

  express_route_gateway_name = "pvc-express-route-gateway"
  ip_configurations = [
    {
      name                          = "default"
      public_ip_address_id          = module.express_route_gateway_public_ip.public_ip_id
      private_ip_address_allocation = "Dynamic"
      subnet_id = lookup({
        for k, v in module.subnet : v.subnet_name => v.subnet_id
      }, "jump-box-snet")
    }
  ]
  location            = var.config["location"]
  resource_group_name = var.config["resource_group"]["pvc"]
  default_tags        = local.global_plus_env_tag

  depends_on = [module.resource_group, module.subnet, module.express_route_gateway_public_ip]

}

module "virtual_network_gateway_connection" {
  source = "../../../modules/virtual_network_gateway_connection"

  express_route_circuit_id   = module.express_route_circuit.express_route_circuit_id
  network_gateway_name       = var.config["network"]["virtual_network_gateway"]["name"]
  network_gateway_type       = var.config["network"]["virtual_network_gateway"]["type"]
  virtual_network_gateway_id = module.virtual_network_gateway.vpn_gateway_id
  location                   = var.config["location"]
  resource_group_name        = var.config["resource_group"]["pvc"]
  default_tags               = local.global_plus_env_tag

  depends_on = [module.resource_group, module.express_route_circuit, module.virtual_network_gateway]
}


module "express_route_global_reach" {
  source = "../../../modules/express_route_global_reach"

  gr_connection_name = "gr_connection"
  gr_remote_auth_key = module.vmware_private_cloud.express_route_auth_key_id
  gr_remote_expr_id  = module.express_route_gateway.express_route_gateway_id
  private_cloud_id   = module.vmware_private_cloud.private_cloud_id

}