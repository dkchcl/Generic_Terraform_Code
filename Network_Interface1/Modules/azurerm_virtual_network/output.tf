# output "subnet_ids" {
#   value = {
#     for vnet_key, vnet in azurerm_virtual_network.vnet :
#     vnet_key => [
#       for sn in vnet.subnet : sn.id
#     ]
#   }
# }

# output "subnet_ids" {
#   value = {
#     for vnet_key, vnet in azurerm_virtual_network.vnet :
#     vnet_key => {
#       for sn in vnet.subnet :
#       sn.name => sn.id
#     }
#   }
# }
output "subnet_ids" {
  value = {
    for vnet_key, vnet in azurerm_virtual_network.vnet :
    vnet_key => {
      for sn in vnet.subnet : sn.name => sn.id
    }
  }
}