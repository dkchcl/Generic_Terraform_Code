# Resource Groups
rg_name = {
  rg1 = {
    name       = "prod_rg_01"
    location   = "westus"
    managed_by = "Terraform"
    tags = {
      project    = "tech-007"
      env        = "prod"
      team       = "prod-007"
      created_by = "Dinesh"
    }
  }

  rg2 = {
    name     = "prod_rg_02"
    location = "eastus"
  }
}

# Virtual Networks
vnet_name = {
  vnet1 = {
    name                           = "prod-vnet-01"
    location                       = "westus"
    resource_group_name            = "prod_rg_01"
    address_space                  = ["10.0.0.0/16"]
    bgp_community                  = "12076:20000"
    dns_servers                    = ["10.1.0.4", "10.1.0.5"]
    edge_zone                      = null
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
        # route_table_id                                = "rt-id-01"
        service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"]
        # service_endpoint_policy_ids                   = ["sep-id-01"]

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
        name             = "subnet-02"
        address_prefixes = ["10.0.2.0/24"]
        # security_group and other fields are optional — remove or set to null if not needed
        default_outbound_access_enabled               = false
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = true
        service_endpoints                             = null
        service_endpoint_policy_ids                   = null
        delegation                                    = null
      }
    }

    # ip_address_pool = {
    #   id                     = 
    #   number_of_ip_addresses = 
    # }

    # ddos_protection_plan = {
    #   id     = "ddos-plan-id-01"
    #   enable = true
    # }

    encryption = {
      enforcement = "AllowUnencrypted"
    }

    tags = {
      env = "prod"
    }

  }

  "vnet2" = {
    name                = "prod-vnet-02"
    location            = "westus"
    resource_group_name = "prod_rg_02"
    address_space       = ["10.2.0.0/16"]

    bgp_community                  = null
    dns_servers                    = null
    edge_zone                      = null
    flow_timeout_in_minutes        = null
    private_endpoint_vnet_policies = null

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

    ddos_protection_plan = null
    encryption           = null
    ip_address_pool      = null
  }
}

# Network Security Groups

nsgs = {
  nsg1 = {
    name                = "prodnsg01"
    location            = "westus"
    resource_group_name = "prod_rg_01"

    security_rule = [
      {
        name                       = "SSH_Rule"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        description                = "Allow ssh port"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      {
        name                         = "MultiPortsAndPrefixesRule1"
        priority                     = 200
        direction                    = "Inbound"
        access                       = "Allow"
        protocol                     = "Tcp"
        description                  = "Allow multiple ports from multiple prefixes"
        source_port_ranges           = ["1000-2000", "3000", "443"]
        destination_port_ranges      = ["80", "8080", "10000-10010"]
        source_address_prefixes      = ["10.0.0.0/24", "192.168.1.0/24"]
        destination_address_prefixes = ["0.0.0.0/0", ]
      },

      {
        name                         = "MultiPortsAndPrefixesRule2"
        priority                     = 300
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "Tcp"
        description                  = "Allow multiple ports to multiple prefixes"
        source_port_ranges           = ["1000-2000", "3000", "443"]
        destination_port_ranges      = ["80", "8080", "10000-10010"]
        source_address_prefixes      = ["10.0.1.0/24", "192.168.2.0/24"]
        destination_address_prefixes = ["0.0.0.0/0", ]
      }
    ]

    tags = {
      env = "prod"
    }
  }
}


# Network Interface Configuration

nic_name = {
  nic1 = {
    name                = "prod-nic-01"
    location            = "west us"
    resource_group_name = "prod_rg_01"
    vnet_key            = "vnet2" # ye tu apne vnet map me jo key use kar raha hai woh dalega
    subnet_index        = 0       # agar vnetA ke subnets list ka index 0 hai

    # IP Configuration
    ip_configuration = [
      {
        name = "prod-ip-config1"
        # subnet_id                                          = "/subscriptions/b398fea1-2f06-4948-924a-121d4ed265b0/resourceGroups/prod_rg_01/providers/Microsoft.Network/virtualNetworks/prod-vnet-01/subnets/subnet-02"
        private_ip_address_allocation                      = "Dynamic"
        private_ip_address_version                         = "IPv4"
        public_ip_address_id                               = null
        gateway_load_balancer_frontend_ip_configuration_id = null
        primary                                            = true
        private_ip_address                                 = null
      },

      {
        name = "prod-ip-config2"
        # subnet_id                                          = "/subscriptions/b398fea1-2f06-4948-924a-121d4ed265b0/resourceGroups/prod_rg_01/providers/Microsoft.Network/virtualNetworks/prod-vnet-01/subnets/subnet-02"
        private_ip_address_allocation                      = "Dynamic"
        private_ip_address_version                         = "IPv4"
        public_ip_address_id                               = null
        gateway_load_balancer_frontend_ip_configuration_id = null
        primary                                            = false
        private_ip_address                                 = null
      }
    ]

    # Optional Features
    auxiliary_mode                 = null
    auxiliary_sku                  = null
    dns_servers                    = ["8.8.8.8", "8.8.4.4"]
    edge_zone                      = null
    ip_forwarding_enabled          = false
    accelerated_networking_enabled = false
    internal_dns_name_label        = null
    tags = {
      "Environment" = "prodelopment"
      "Owner"       = "prodOps Team"
    }
  }

  nic2 = {
    name                = "prod-nic-02"
    location            = "westus"
    resource_group_name = "prod_rg_02"
    vnet_key            = "vnet2"
    subnet_index        = 0
    # IP Configuration
    ip_configuration = [
      {
        name = "prod-ip-config3"
        # subnet_id                     = "/subscriptions/b398fea1-2f06-4948-924a-121d4ed265b0/resourceGroups/prod_rg_02/providers/Microsoft.Network/virtualNetworks/prod-vnet-02/subnets/subnet-A"
        private_ip_address_allocation = "Dynamic"
        # private_ip_address_version                         = "IPv4"
        # public_ip_address_id                               = null
        # gateway_load_balancer_frontend_ip_configuration_id = null
        # primary                                            = true
        # private_ip_address                                 = null
      }
    ]
  }

  nic3 = {
    name                = "prod-nic-03"
    location            = "westus"
    resource_group_name = "prod_rg_02"
    vnet_key            = "vnet2"
    subnet_index        = 1
    # IP Configuration
    ip_configuration = [
      {
        name = "prod-ip-config4"
        # subnet_id                     = "/subscriptions/b398fea1-2f06-4948-924a-121d4ed265b0/resourceGroups/prod_rg_02/providers/Microsoft.Network/virtualNetworks/prod-vnet-02/subnets/subnet-A"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}




