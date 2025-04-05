resource "azurerm_resource_group" "rg" {
  name     = "n14804-resource-group"
  location = "Canada Central"
}

module "vnet" {
  source          = "./modules/vnet-n01514804"
  location        = var.location
  resource_group  = azurerm_resource_group.rg.name
}

module "vm" {
  source         = "./modules/vm-n01514804"
  location       = var.location
  resource_group = azurerm_resource_group.rg.name
  subnet_id      = module.vnet.subnet_id
}

module "lb" {
  source         = "./modules/lb-n01514804"
  location       = var.location
  resource_group = azurerm_resource_group.rg.name
}

module "db" {
  source         = "./modules/db-n01514804"
  location       = var.location
  resource_group = azurerm_resource_group.rg.name
}
