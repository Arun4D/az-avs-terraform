variable "config" {}

variable "environment_tags" {}

variable "global_tags" {}

variable "global_map" {}

/*variable "nsx_manager" {}

variable "nsx_username" {}

variable "nsx_password" {}*/

data "nsxt_policy_edge_cluster" "EC" {
  display_name = "TNTxx-CLSTR"
}

data "nsxt_policy_tier0_gateway" "T0" {
  display_name = "TNTxx-T0"
}

data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name = "TNTxx-OVERLAY-TZ"
}

