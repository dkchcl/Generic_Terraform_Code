module "rg" {
  source  = "../../Modules/azurerm_resource_group"
  rg_name = var.rg_name
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_virtual_network"
  vnet_name  = var.vnet_name
}

module "public_ip" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_public_ip"
  public_ip  = var.public_ip
}

module "nic" {
  depends_on    = [module.rg, module.nsg, module.vnet, module.public_ip]
  source        = "../../Modules/azurerm_network_interface"
  nics          = var.nics
  subnet_ids    = module.vnet.subnet_ids # 👈 Pass output from VNet module
  public_ip_ids = module.public_ip.public_ip_id
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../Modules/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "nic_nsg_assoc" {
  source  = "../../Modules/azurerm_nic_nsg_assoc"
  nic_ids = module.nic.nic_id
  nsg_ids = module.nsg.nsg_id  
}








