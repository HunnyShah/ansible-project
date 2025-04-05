output "vm_id" {
  description = "ID of the Windows VM"
  value       = azurerm_virtual_machine.windows_vm[0].id
}

output "vm_hostname" {
  description = "Windows VM hostname"
  value       = azurerm_virtual_machine.windows_vm[0].name
}

output "vm_private_ip" {
  description = "Private IP address of the Windows VM"
  value       = azurerm_network_interface.windows_nic.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.windows_pip.ip_address
}

output "vm_dns_name" {
  description = "Public DNS name of the Windows VM"
  value       = azurerm_public_ip.windows_pip.fqdn
}

