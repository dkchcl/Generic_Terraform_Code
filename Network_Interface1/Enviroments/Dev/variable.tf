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


    ip_configuration = list(object({
      name                                               = string
      subnet_id                                          = string
      private_ip_address_allocation                      = string
      vnet_key                                           = optional(string)
      subnet_name                                        = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      primary                                            = optional(bool)
      private_ip_address                                 = optional(string)
      public_ip_key                                      = optional(string)
      public_ip_index                                    = optional(number)
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


