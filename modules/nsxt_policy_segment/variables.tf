variable "description" {}
variable "display_name" {}
variable "nsx_id" {}
variable "edge_cluster_path" {}
variable "failover_mode" {}
variable "default_rule_logging" {}
variable "enable_firewall" {}
variable "enable_standby_relocation" {}
variable "tier0_path" {}
variable "route_advertisement_types" {}
variable "pool_allocation" {}
variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}