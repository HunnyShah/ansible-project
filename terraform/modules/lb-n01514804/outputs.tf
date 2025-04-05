output "lb_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}
