output "vm_ids" {
  description = "IDs of the Linux VMs"
  value       = { for k, v in azurerm_virtual_machine.linux_vm : k => v.id }
}

output "vm_hostnames" {
  description = "List of Linux VM hostnames"
  value       = { for k, v in azurerm_virtual_machine.linux_vm : k => v.name }
}

output "vm_private_ips" {
  description = "Private IP addresses of the VMs"
  value       = { for k, v in azurerm_network_interface.linux_nic : k => v.private_ip_address }
}

output "vm_public_ips" {
  description = "Public IP addresses of the VMs"
  value       = { for k, v in azurerm_public_ip.linux_pip : k => v.ip_address }
}

output "vm_dns_names" {
  description = "Public DNS names of the VMs"
  value       = { for k, v in azurerm_public_ip.linux_pip : k => v.fqdn }
}

output "nic_ids" {
  description = "Network Interface IDs of the Linux VMs"
  value       = [for nic in azurerm_network_interface.linux_nic : nic.id]
}