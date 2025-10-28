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
        service_endpoints                             = null
        service_endpoint_policy_ids                   = null
        delegation                                    = null
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

# Public IP Addresses

public_ip = {
  "pip1" = {
    name                 = "dev-pip-01"
    resource_group_name  = "dev_rg_01"
    location             = "Central India"
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
    resource_group_name = "dev_rg_01"
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

    # IP Configuration
    ip_configuration = [
      {
        name                          = "dev-ip-config1"
        subnet_id                     = "" # blank, module will auto-pick from vnet_key + subnet_index
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
        vnet_key                      = "vnet2" # ye tu apne vnet map me jo key use kar raha hai woh dalega
        subnet_index                  = 0       # agar vnet2 ke subnets list ka index 0 hai
        public_ip_key                 = "pip1"
        public_ip_index               = 0
      },

      {
        name                          = "dev-ip-config2"
        subnet_id                     = "" # blank, module will auto-pick from vnet_key + subnet_index
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = false
        vnet_key                      = "vnet2" # ye tu apne vnet map me jo key use kar raha hai woh dalega
        subnet_index                  = 0       # agar vnet2 ke subnets list ka index 0 hai
        public_ip_key                 = "pip1"
        public_ip_index               = 0
      }
    ]

    # Optional Features
    dns_servers                    = ["8.8.8.8", "8.8.4.4"]
    ip_forwarding_enabled          = false
    accelerated_networking_enabled = false
    tags = {
      "Environment" = "Development"
      "Owner"       = "DevOps Team"
    }
  }

  nic2 = {
    name                = "dev-nic-02"
    location            = "westus"
    resource_group_name = "dev_rg_02"

    # IP Configuration
    ip_configuration = [
      {
        name                          = "dev-ip-config3"
        subnet_id                     = "" # blank, module will auto-pick from vnet_key + subnet_index
        private_ip_address_allocation = "Dynamic"
        vnet_key                      = "vnet2" # ye tu apne vnet map me jo key use kar raha hai woh dalega
        subnet_index                  = 0       # agar vnet2 ke subnets list ka index 0 hai
        public_ip_key                 = "pip1"
        public_ip_index               = 0
      }
    ]
  }

  nic3 = {
    name                = "dev-nic-03"
    location            = "westus"
    resource_group_name = "dev_rg_02"

    # IP Configuration
    ip_configuration = [
      {
        name                          = "dev-ip-config4"
        subnet_id                     = "" # blank, module will auto-pick from vnet_key + subnet_index
        private_ip_address_allocation = "Dynamic"
        vnet_key                      = "vnet2" # ye tu apne vnet map me jo key use kar raha hai woh dalega
        subnet_index                  = 0       # agar vnet2 ke subnets list ka index 0 hai
        public_ip_key                 = "pip1"
        public_ip_index               = 0
      }
    ]
  }
}

# Linux Virtual Machines

linux_vms = {
  vm1 = {
    name                  = "dev-vm-01"
    location              = "west us"
    resource_group_name   = "dev_rg_01"
    network_interface_ids = ["/subscriptions/xxxx/resourceGroups/rg-demo/providers/Microsoft.Network/networkInterfaces/nic1"]
    size                  = "Standard_B1ms"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }

    admin_username                  = "adminuser"
    admin_password                  = "Bbpl@#123456"
    disable_password_authentication = false

    # admin_ssh_key = [
    #   {
    #     username   = "azureuser"
    #     public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
    #   }
    # ]

    tags = {
      environment = "dev"
      project     = "demo"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    boot_diagnostics = {
      storage_account_uri = "https://mystorageaccount.blob.core.windows.net/"
    }

    identity = {
      type = "SystemAssigned"
    }

    plan = {
      name      = "demo-plan"
      product   = "demo-product"
      publisher = "demo-publisher"
    }

    additional_capabilities = {
      ultra_ssd_enabled   = false
      hibernation_enabled = false
    }

    # gallery_application = [
    #   {
    #     version_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Compute/galleries/myGallery/applications/myApp/versions/1.0.0"
    #     order      = 1
    #     tag        = "stable"
    #   }
    # ]

    # secret = [
    #   {
    #     key_vault_id = "/subscriptions/xxxx/resourceGroups/rg-demo/providers/Microsoft.KeyVault/vaults/mykv"
    #     certificate = [
    #       {
    #         url = "https://mykv.vault.azure.net/certificates/cert1"
    #       }
    #     ]
    #   }
    # ]

    os_image_notification = {
      timeout = "PT15M"
    }

    termination_notification = {
      enabled = true
      timeout = "PT10M"
    }
  }

  vm2 = {
    name                  = "dev-vm-02"
    location              = "westus"
    resource_group_name   = "dev_rg_01"
    network_interface_ids = ["/subscriptions/xxxx/resourceGroups/rg-demo/providers/Microsoft.Network/networkInterfaces/nic2"]
    size                  = "Standard_B2s"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }

    admin_username                  = "adminuser"
    admin_password                  = "Bbpl@#123456"
    disable_password_authentication = false

    tags = {
      environment = "test"
      project     = "demo"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }
}







