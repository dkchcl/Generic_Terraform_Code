resource "azurerm_network_interface" "nic" {
  for_each            = var.nic_name                   
  name                = each.value.name                
  location            = each.value.location            
  resource_group_name = each.value.resource_group_name 

  # Dynamic block to handle multiple IP configurations per NIC
  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration # Iterate over the list of IP configurations defined for this NIC
    content {
      name                                               = ip_configuration.value.name                                              
      subnet_id                                          = var.subnet_ids[each.value.vnet_key][each.value.subnet_index]              # Subnet resource ID to which this IP config is connected
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation                      # Specifies how the private IP address is assigned (Dynamic or Static)
      private_ip_address_version                         = ip_configuration.value.private_ip_address_version                         # (Optional) IP address version (e.g., IPv4, IPv6)
      public_ip_address_id                               = ip_configuration.value.public_ip_address_id                               # (Optional) Public IP resource ID associated with this IP config
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id # (Optional) ID for Gateway Load Balancer frontend IP config, if applicable
      primary                                            = ip_configuration.value.primary                                            # (Optional) Marks this IP configuration as primary
      private_ip_address                                 = ip_configuration.value.private_ip_address                                 # (Optional) Assigns a specific private IP address statically
    }
  }

  auxiliary_mode                 = each.value.auxiliary_mode                 # (Optional) Auxiliary mode of the NIC, used for specific Azure scenarios
  auxiliary_sku                  = each.value.auxiliary_sku                  # (Optional) SKU for the auxiliary NIC, if specified
  dns_servers                    = each.value.dns_servers                    # (Optional) List of DNS server IP addresses to assign to the NIC
  edge_zone                      = each.value.edge_zone                      # (Optional) Azure edge zone where this NIC will be deployed
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled          # (Optional) Enables or disables IP forwarding on the NIC
  accelerated_networking_enabled = each.value.accelerated_networking_enabled # (Optional) Enables or disables accelerated networking on the NIC
  internal_dns_name_label        = each.value.internal_dns_name_label        # (Optional) Internal DNS name label within the Azure network scope
  tags                           = each.value.tags                           # (Optional) Tags to associate with the NIC resource as key-value pairs
}

























