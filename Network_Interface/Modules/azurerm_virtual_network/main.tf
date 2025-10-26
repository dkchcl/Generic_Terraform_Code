# Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet_name
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  # Optional configurations with 'lookup()' to avoid errors if values are missing
  bgp_community                  = lookup(each.value, "bgp_community", null)
  dns_servers                    = lookup(each.value, "dns_servers", null)
  edge_zone                      = lookup(each.value, "edge_zone", null)
  flow_timeout_in_minutes        = lookup(each.value, "flow_timeout_in_minutes", null)
  private_endpoint_vnet_policies = lookup(each.value, "private_endpoint_vnet_policies", null)
  tags                           = lookup(each.value, "tags", {})

  # Optional ip_address_pool block (mutually exclusive with address_space)
  dynamic "ip_address_pool" {
    for_each = lookup(each.value, "ip_address_pool", null) != null ? [each.value.ip_address_pool] : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  # Define subnets inside the virtual network
  dynamic "subnet" {
    # Loop through each subnet defined in the input variable
    for_each = lookup(each.value, "subnets", {})
    content {
      name                                          = subnet.value.name
      address_prefixes                              = subnet.value.address_prefixes
      security_group                                = lookup(subnet.value, "security_group", null)
      default_outbound_access_enabled               = lookup(subnet.value, "default_outbound_access_enabled", null)
      private_endpoint_network_policies             = lookup(subnet.value, "private_endpoint_network_policies", null)
      private_link_service_network_policies_enabled = lookup(subnet.value, "private_link_service_network_policies_enabled", null)
      route_table_id                                = lookup(subnet.value, "route_table_id", null)
      service_endpoints                             = lookup(subnet.value, "service_endpoints", null)
      service_endpoint_policy_ids                   = lookup(subnet.value, "service_endpoint_policy_ids", null)

      # Delegation the subnet to specific Azure services
      dynamic "delegation" {
        for_each = lookup(subnet.value, "delegation", null) != null ? [subnet.value.delegation] : []
        content {
          name = delegation.value.name

          dynamic "service_delegation" {
            for_each = lookup(delegation.value, "service_delegation", [])
            content {
              name    = service_delegation.value.name
              actions = lookup(service_delegation.value, "actions", [])
            }
          }
        }
      }
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = lookup(each.value, "ddos_protection_plan", null) != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = lookup(each.value, "encryption", null) != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }
}





