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






