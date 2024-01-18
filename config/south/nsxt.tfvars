config = {
  tier1_gateway = {
    description               = "AVS01-Tier1 provisioned"
    display_name              = "AVS01-Tier1"
    nsx_id                    = "AVS01-Tier1"
    failover_mode             = "PREEMPTIVE"
    default_rule_logging      = "false"
    enable_firewall           = "true"
    enable_standby_relocation = "false"
    route_advertisement_types = ["TIER1_STATIC_ROUTES", "TIER1_CONNECTED"]
    pool_allocation           = "ROUTING"

    segment = {
      names            = ["Segment_1", "Segment_2", "Segment_3"]
      ips              = ["10.100.1.1/24", "10.100.2.1/24", "10.100.3.1/24"]
      replication_mode = "MTEP"
    }
  }

  nsx_manager  = "https://10.0.0.13"
  nsx_username = "test"
  nsx_password = "dummy"
}

environment_tags = {
  environment = "dev"
  entity      = ""
  approval    = ""
  cost_center = ""
  owner       = ""
}
