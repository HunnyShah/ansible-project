resource "azurerm_lb" "lb" {
  name                = "n14804-lb"
  location            = var.location
  resource_group_name = var.resource_group

  frontend_ip_configuration {
    name                 = "public-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "n14804-lb-ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}
