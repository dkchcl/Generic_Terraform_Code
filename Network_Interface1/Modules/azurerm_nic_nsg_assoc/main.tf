# resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
#   for_each = {
#     for idx, nic_id in var.nic_ids :
#     idx => nic_id
#   }
#   network_interface_id      = each.value
#   network_security_group_id = var.nsg_ids
# }

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  for_each = var.nsg_ids

  network_interface_id      = var.nic_ids[tonumber(regex("\\d+", each.key))]
  network_security_group_id = each.value
}



