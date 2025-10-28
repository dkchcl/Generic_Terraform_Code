output "nsg_id" {
  description = "The ID of the Network security group"
  value       = azurerm_network_security_group.nsg.id
}
