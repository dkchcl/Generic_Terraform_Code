output "nsg_id" {
  value = { for k, nsg in azurerm_network_security_group.nsg : k => nsg.id }
}
