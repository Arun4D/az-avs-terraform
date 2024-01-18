module "nsxt_policy_tier1_gateway" {
  source = "../../../modules/nsxt_policy_tier1_gateway"

  description               = var.config["tier1_gateway"]["description"]
  display_name              = var.config["tier1_gateway"]["display_name"]
  edge_cluster_path         = data.nsxt_policy_edge_cluster.EC.path
  enable_firewall           = var.config["tier1_gateway"]["enable_firewall"]
  enable_standby_relocation = var.config["tier1_gateway"]["enable_standby_relocation"]
  failover_mode             = var.config["tier1_gateway"]["failover_mode"]
  nsx_id                    = var.config["tier1_gateway"]["nsx_id"]
  pool_allocation           = var.config["tier1_gateway"]["pool_allocation"]
  route_advertisement_types = var.config["tier1_gateway"]["route_advertisement_types"]
  tier0_path                = data.nsxt_policy_tier0_gateway.T0.path
  default_rule_logging      = var.config["tier1_gateway"]["default_rule_logging"]

  default_tags              = local.global_plus_env_tag
}

module "nsxt_policy_segment" {
  source = "../../../modules/nsxt_policy_segment"

  connectivity_path   = module.nsxt_policy_tier1_gateway.avs01_tier1_tenant1_path
  replication_mode    = var.config["tier1_gateway"]["segment"]["replication_mode"]
  segment_IPs         = var.config["tier1_gateway"]["segment"]["ips"]
  segment_names       = var.config["tier1_gateway"]["segment"]["names"]
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  default_tags        = local.global_plus_env_tag

  depends_on = [module.nsxt_policy_tier1_gateway, data.nsxt_policy_transport_zone]
}