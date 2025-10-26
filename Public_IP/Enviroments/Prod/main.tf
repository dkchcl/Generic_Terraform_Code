module "rg" {
  source  = "../../Modules/azurerm_resource_group"
  rg_name = var.rg_name
}

module "public_ip" {
  depends_on = [ module.rg ]
  source = "../../Modules/azurerm_public_ip"
  public_ip = var.public_ip
}










