resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  # Dynamic block to handle multiple IP configurations per NIC
  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration # Iterate over the list of IP configurations defined for this NIC
    content {
      name = ip_configuration.value.name

      # 🔹 Subnet selection logic (either direct subnet_id or via vnet_key/subnet_index)
      subnet_id                                          = coalesce(ip_configuration.value.subnet_id, try(var.subnet_ids[each.value.vnet_key][each.value.subnet_index], null))
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation # Specifies how the private IP address is assigned (Dynamic or Static)
      private_ip_address_version                         = lookup(ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = coalesce(ip_configuration.value.public_ip_address_id, try(var.public_ip_ids[each.value.public_ip_key][each.value.public_ip_index], null))
      gateway_load_balancer_frontend_ip_configuration_id = lookup(ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      primary                                            = lookup(ip_configuration.value, "primary", false)
      private_ip_address                                 = lookup(ip_configuration.value, "private_ip_address", null)

    }
  }

  auxiliary_mode                 = lookup(each.value, "auxiliary_mode", null)
  auxiliary_sku                  = lookup(each.value, "auxiliary_sku", null)
  dns_servers                    = lookup(each.value, "dns_servers", [])
  edge_zone                      = lookup(each.value, "edge_zone", null)
  ip_forwarding_enabled          = lookup(each.value, "ip_forwarding_enabled", false)
  accelerated_networking_enabled = lookup(each.value, "accelerated_networking_enabled", false)
  internal_dns_name_label        = lookup(each.value, "internal_dns_name_label", null)
  tags                           = lookup(each.value, "tags", {})
}

























