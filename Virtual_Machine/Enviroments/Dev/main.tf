module "rg" {
  source  = "../../Modules/azurerm_resource_group"
  rg_name = var.rg_name
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_virtual_network"
  vnet_name  = var.vnet_name
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "nic" {
  depends_on = [module.rg, module.nsg, module.vnet]
  source     = "../../Modules/azurerm_network_interface"
  nic_name   = var.nic_name
  subnet_ids  = module.vnet.subnet_ids   # 👈 Pass output from VNet module
}

module "public_ip" {
  depends_on = [ module.rg ]
  source = "../../Modules/azurerm_public_ip"
  public_ip = var.public_ip
}










