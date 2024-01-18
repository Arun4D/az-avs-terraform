
resource "nsxt_policy_tier1_gateway" "avs01-tier1-tenant1" {
  description               = var.description
  display_name              = var.display_name
  nsx_id                    = var.nsx_id
  edge_cluster_path         = var.edge_cluster_path
  failover_mode             = var.failover_mode
  default_rule_logging      = var.default_rule_logging
  enable_firewall           = var.enable_firewall
  enable_standby_relocation = var.enable_standby_relocation
  tier0_path                = var.tier0_path
  route_advertisement_types = var.route_advertisement_types
  pool_allocation           = var.pool_allocation
}
