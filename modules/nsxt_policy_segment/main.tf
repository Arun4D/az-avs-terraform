locals {
  segment_names = {
    for index, segment in nsxt_policy_segment.segment :
    segment.display_name => segment.id
  }
}

resource "nsxt_policy_segment" "segment" {
  count               = length(var.segment_names)
  display_name        = var.segment_names[count.index]
  description         = "Terraform provisioned Segment"
  connectivity_path   = var.connectivity_path
  transport_zone_path = var.transport_zone_path
  replication_mode =  var.replication_mode
  subnet {
    cidr = var.segment_IPs[count.index]
    # dhcp_ranges = ["10.197.7.193-10.197.7.200"]
  }
}

