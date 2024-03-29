config = {
  location = "northeurope"
  vnet = {
    name          = "avs-net"
    address_space = ["192.168.1.0/24"]
  }

  avs = {
    avs_sku                     = "AV36"
    avs_host_count              = 3
    avs_network_block           = "10.1.0.0/22"
    nsxt_password               = "test"
    vcenter_password            = "test"
    internet_connection_enabled = false
    cluster = {
      avs = {
        cluster_node_count = 3
        avs_cluster_sku    = "AV36"
      }
      dmz = {
        cluster_node_count = 3
        avs_cluster_sku    = "AV36"
      }
      sql = {
        cluster_node_count = 3
        avs_cluster_sku    = "AV36"
      }
    }
  }
  resource_group = {
    pvc = "private-cloud-rg"
    jmp = "jump-box-rg"
    nw  = "network-rg"
  }
  nsg = {
    gateway  = "gateway-nsg"
    bastion  = "bastion-nsg"
    jump-box = "jump-box-nsg"
  }

  subnet = {
    gateway  = ["192.168.1.0/27"]
    bastion  = ["192.168.1.64/26"]
    jump-box = ["192.168.1.128/25"]
  }
  network = {
    express_route_circuit = {
      name                  = "avs-erc"
      service_provider_name = "Equinix"
      peering_location      = "Washington DC"
      bandwidth_in_mbps     = 1000
      sku = {
        tier   = "Standard"
        family = "MeteredData"
      }
    }
    peering = {
      peering_type                  = "AzurePrivatePeering"
      primary_peer_address_prefix   = "10.0.0.0/30"
      secondary_peer_address_prefix = "10.0.0.0/30"
      vlan_id                       = 100
    }
    virtual_network_gateway = {
      name          = "avs-vgw"
      type          = "ExpressRoute"
      vpn_type      = "PolicyBased"
      sku           = "HighPerformance"
      asn           = 65515
      active_active = false
      enable_bgp    = false
    }
    virtual_network_gateway_connection = {
      name = "avs-vgw-con"
      type = "ExpressRoute"
    }
  }
  virtual_machine = {
    dev = {
      jump-box = {
        instance_name  = ["jump-box1"]
        instance_count = 1
        has_public_ip  = false
        vm_size        = ["Standard_B2ms"]
        image          = "Windows19"
        os_type        = "windows"
        os_disk_size   = "P10"
        data_disk_size = ["P3"]
        license_type   = "Windows_Server"
        ip_address = [
          [
            {
              nic_name   = "nic1"
              ip_configs = [{ name = "config", allocation_type = "Static", ip = "10.210.1.2", primary = true }]
            }
          ]
        ]
        tags = {
          operating_hours          = "24X7"
          operating_hours_override = "Yes"
          tier                     = "T2"
          created_by               = ""
          service                  = "jump_box"
        }
      }
    }
  }
}

environment_tags = {
  environment = "dev"
  entity      = ""
  approval    = ""
  cost_center = ""
  owner       = ""
}
