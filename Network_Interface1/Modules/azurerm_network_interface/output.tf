output "nic_id" {
  description = "List of NIC IDs"
  value       = [for nic in azurerm_network_interface.nic : nic.id]
}

