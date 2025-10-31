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

      "subnet3" = {
        name                                          = "subnet-03"
        address_prefixes                              = ["10.0.3.0/24"]
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
      "subnetC" = {
        name             = "subnet-C"
        address_prefixes = ["10.2.3.0/24"]
        # optional fields omitted if not needed
      }
    }
  }
}


# Public IP Addresses

public_ip = {
  "pip1" = {
    name                 = "dev-pip-01"
    resource_group_name  = "dev_rg_01"
    location             = "eastus"
    allocation_method    = "Static"
    zones                = ["1", "2"]
    ddos_protection_mode = "Enabled"
    # ddos_protection_plan_id = ""
    domain_name_label       = "mywebapp"
    domain_name_label_scope = "NoReuse"
    # edge_zone               = "westus"
    idle_timeout_in_minutes = 4

    # ip_routing_preference = "MicrosoftNetwork" # Default routing

    ip_version = "IPv4"
    # public_ip_prefix_id = ""
    # reverse_fqdn = "dev-pip-01.eastus.cloudapp.azure.com"
    sku      = "Standard"
    sku_tier = "Regional"
    tags = {
      env = "dev"
    }
  }

  "pip2" = {
    name                = "dev-pip-02"
    resource_group_name = "dev_rg_02"
    location            = "westus"
    allocation_method   = "Static"
  }
}

# Network Interface Configuration

nics = {
  nic1 = {
    name                = "dev-nic-01"
    location            = "west us"
    resource_group_name = "dev_rg_01"

    ip_configuration = [
      {
        name                          = "ipconfig1"
        subnet_id                     = "" # empty = trigger lookup
        vnet_key                      = "vnet1"
        subnet_name                   = "subnet-02"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }

  nic2 = {
    name                = "dev-nic-02"
    location            = "west us"
    resource_group_name = "dev_rg_02"

    ip_configuration = [
      {
        name                          = "ipconfig1"
        subnet_id                     = "" # empty = trigger lookup
        vnet_key                      = "vnet2"
        subnet_name                   = "subnet-A"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
  nic3 = {
    name                = "dev-nic-03"
    location            = "west us"
    resource_group_name = "dev_rg_02"

    ip_configuration = [
      {
        name                          = "ipconfig2"
        subnet_id                     = "" # empty = trigger lookup
        vnet_key                      = "vnet2"
        subnet_name                   = "subnet-C"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}

# Network Security Groups

nsgs = {
  nsg1 = {
    name                = "devnsg01"
    location            = "westus"
    resource_group_name = "dev_rg_01"

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
      env = "dev"
    }
  }
}











