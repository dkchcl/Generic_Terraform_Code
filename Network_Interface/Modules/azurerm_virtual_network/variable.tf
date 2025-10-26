# Variable for virtual networks using a map
variable "vnet_name" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)

    bgp_community                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)         # Edge zone (for latency-sensitive workloads)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string)

    # subnet configurations
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

    # Optional IP address pool (alternative to address_space)
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))
    tags = optional(map(string))
  }))

}



