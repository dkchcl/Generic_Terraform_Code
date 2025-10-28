output "pip_ids" {
  value = { for k, pip in azurerm_public_ip.pip : k => pip.id }
}


