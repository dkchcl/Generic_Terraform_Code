# Variable for RGs
variable "rg_name" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

# Variable for Vnet & Subnets
variable "vnet_name" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)

    bgp_community                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string)

    subnets = optional(map(object({
      name                                          = string
      address_prefixes                              = list(string)
      security_group                                = optional(string)
      default_outbound_access_enabled               = optional(bool)
      private_endpoint_network_policies             = optional(string)
      private_link_service_network_policies_enabled = optional(bool)
      route_table_id                                = optional(string)
      service_endpoints                             = optional(set(string))
      service_endpoint_policy_ids                   = optional(list(string))
      delegation = optional(object({
        name = string
        service_delegation = list(object({
          name    = string
          actions = optional(list(string))
        }))
      }))
    })))

    ddos_protection_plan = optional(object({
      id     = string
      enable = string
    }))

    encryption = optional(object({
      enforcement = string
    }))

    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))
    tags = optional(map(string))
  }))
}

#Variable for NSGs
variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    security_rule = optional(list(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      description                  = optional(string)
      source_port_range            = optional(string)
      destination_port_range       = optional(string)
      source_address_prefix        = optional(string)
      destination_address_prefix   = optional(string)
      source_port_ranges           = optional(list(string))
      destination_port_ranges      = optional(list(string))
      source_address_prefixes      = optional(list(string))
      destination_address_prefixes = optional(list(string))
    })))
    tags = optional(map(string))
  }))
}

# Variable for Public IPs

variable "public_ip" {
  description = "Arguments for creating an Azure Public IP resource."
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
  }))
}

# Variable for NIC

variable "nics" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    vnet_key     = optional(string)
    subnet_index = optional(number)
    # List of IP configuration blocks for the NIC
    ip_configuration = list(object({
      name                                               = string
      subnet_id                                          = string # The ID of the subnet to which this IP config is attached
      private_ip_address_allocation                      = string
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      primary                                            = optional(bool)
      private_ip_address                                 = optional(string)
    }))

    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(string))
  }))
}

# Variable for Linux VMs

variable "linux_vms" {
  description = "Configuration for Azure Linux Virtual Machines"
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    network_interface_ids = list(string)
    size                  = string
    os_disk = object({
      caching                          = string
      storage_account_type             = optional(string)
      name                             = optional(string)
      disk_size_gb                     = optional(number)
      disk_encryption_set_id           = optional(string)
      secure_vm_disk_encryption_set_id = optional(string)
      security_encryption_type         = optional(string)
      diff_disk_settings = optional(object({
        option    = string
        placement = optional(string)
      }))
      write_accelerator_enabled = optional(bool)
    })

    # Optional Arguments
    admin_username                  = optional(string)
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool)
    computer_name                   = optional(string)
    custom_data                     = optional(string)
    allow_extension_operations      = optional(bool)
    availability_set_id             = optional(string)
    admin_ssh_key = optional(list(object({
      username   = string
      public_key = string
    })))
    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    license_type                                           = optional(string)
    capacity_reservation_group_id                          = optional(string)
    dedicated_host_id                                      = optional(string)
    dedicated_host_group_id                                = optional(string)
    encryption_at_host_enabled                             = optional(bool)
    eviction_policy                                        = optional(string)
    max_bid_price                                          = optional(number)
    patch_mode                                             = optional(string)
    patch_assessment_mode                                  = optional(string)
    bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
    reboot_setting                                         = optional(string)
    priority                                               = optional(string)
    secure_boot_enabled                                    = optional(bool)
    vtpm_enabled                                           = optional(bool)
    user_data                                              = optional(string)
    zone                                                   = optional(string)
    plan = optional(object({
      name      = string
      product   = string
      publisher = string
    }))
    additional_capabilities = optional(object({
      ultra_ssd_enabled   = optional(bool)
      hibernation_enabled = optional(bool)
    }))
    tags = optional(map(string))

    # Extra Optional Arguments from Docs
    disk_controller_type   = optional(string)
    edge_zone              = optional(string)
    extensions_time_budget = optional(string)
    gallery_application = optional(list(object({
      version_id                                  = string
      automatic_upgrade_enabled                   = optional(bool)
      configuration_blob_uri                      = optional(string)
      order                                       = optional(number)
      tag                                         = optional(string)
      treat_failure_as_deployment_failure_enabled = optional(bool)
    })))
    platform_fault_domain        = optional(number)
    provision_vm_agent           = optional(bool)
    proximity_placement_group_id = optional(string)
    secret = optional(list(object({
      key_vault_id = string
      certificate = list(object({
        url = string
      }))
    })))
    source_image_id = optional(string)
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    os_image_notification = optional(object({
      timeout = optional(string)
    }))
    os_managed_disk_id = optional(string)
    termination_notification = optional(object({
      enabled = bool
      timeout = optional(string)
    }))
    virtual_machine_scale_set_id = optional(string)
  }))
}


