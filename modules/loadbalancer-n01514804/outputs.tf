output "load_balancer_name" {
  description = "The name of the load balancer"
  value       = azurerm_lb.lb.name
}
output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}

output "load_balancer_public_dns" {
  value = azurerm_public_ip.lb_pip.fqdn
}
