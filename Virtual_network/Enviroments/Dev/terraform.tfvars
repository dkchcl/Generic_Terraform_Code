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

# Virtual Networks

vnet_name = {
  vnet1 = {
    name                           = "dev-vnet-01"
    location                       = "westus"
    resource_group_name            = "dev_rg_01"
    address_space                  = ["10.0.0.0/16"]
    bgp_community                  = "12076:20000"
    dns_servers                    = ["10.1.0.4", "10.1.0.5"]
    flow_timeout_in_minutes        = 10
    private_endpoint_vnet_policies = "Disabled"

    # Subnets -
    subnets = {
      "subnet1" = {
        name             = "subnet-01"
        address_prefixes = ["10.0.1.0/24"]
        # security_group                                = "nsg-id-01"
        default_outbound_access_enabled               = true
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = false
        service_endpoints                             = ["Microsoft.Storage", "Microsoft.Sql"]

        delegation = {
          name = "deleg-02"
          service_delegation = [
            {
              name    = "Microsoft.Web/serverFarms"
              actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
            }
          ]
        }
      }

      "subnet2" = {
        name                                          = "subnet-02"
        address_prefixes                              = ["10.0.2.0/24"]
        default_outbound_access_enabled               = false
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = true
      }
    }

    encryption = {
      enforcement = "AllowUnencrypted"
    }

    tags = {
      env = "dev"
    }

  }

  "vnet2" = {
    name                = "dev-vnet-02"
    location            = "westus"
    resource_group_name = "dev_rg_02"
    address_space       = ["10.2.0.0/16"]

    subnets = {
      "subnetA" = {
        name             = "subnet-A"
        address_prefixes = ["10.2.1.0/24"]
        # optional fields omitted if not needed
      }

      "subnetB" = {
        name             = "subnet-B"
        address_prefixes = ["10.2.2.0/24"]
        # optional fields omitted if not needed
      }
    }
  }
}







