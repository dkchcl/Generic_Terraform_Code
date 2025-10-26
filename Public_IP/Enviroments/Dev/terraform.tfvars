# Resource Groups

rg_name = {
  rg1 = {
    name       = "dev_rg_01"
    location   = "westus"
    managed_by = "Terraform"
    tags = {
      project    = "tech-007"
      env        = "dev"
      team       = "dev-007"
      created_by = "Dinesh"
    }
  }

  rg2 = {
    name     = "dev_rg_02"
    location = "eastus"
  }
}

# Public IP Addresses

public_ip = {
  "pip1" = {
    name                 = "dev-pip-01"
    resource_group_name  = "dev_rg_01"
    location             = "Central India"
    allocation_method    = "Static"
    zones                = ["1"]
    ddos_protection_mode = "Disabled"
    # ddos_protection_plan_id = ""
    domain_name_label       = "mypublicip"
    domain_name_label_scope = "NoReuse"
    # edge_zone               = "zone1"
    idle_timeout_in_minutes = 10
    # ip_tags = {
    #   "AcceleratedNetworking" = "Enabled"
    # }
    ip_version = "IPv4"
    # public_ip_prefix_id = ""
    # reverse_fqdn        = "mypublicip.example.com"
    sku      = "Standard"
    sku_tier = "Regional"
    tags = {
      "project" = "demo"
    }
  }

  "pip2" = {
    name                = "dev-pip-02"
    resource_group_name = "dev_rg_01"
    location            = "westus"
    allocation_method   = "Static"
  }
}






