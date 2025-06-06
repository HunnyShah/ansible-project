resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.prefix}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.prefix}-lb"
}

resource "azurerm_lb" "lb" {
  name                = "${var.prefix}-LB"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# Backend Pool
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend-pool"
}

# Backend Pool association for Linux VMs
resource "azurerm_network_interface_backend_address_pool_association" "linux" {
  count = length(var.linux_nic_ids)

  network_interface_id    = var.linux_nic_ids[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
  ip_configuration_name   = "ipconfig"
}

# Load Balancer Probe
resource "azurerm_lb_probe" "probe" {
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "health-probe"
  port                = 80
  protocol            = "Http"
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Load Balancer Rule (HTTP)
resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip-config"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}
