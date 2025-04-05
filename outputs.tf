output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.resource_group.resource_group_name
}

output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = module.network.vnet_name
}

output "subnet_name" {
  description = "The name of the Subnet"
  value       = module.network.subnet_name
}

output "log_analytics_name" {
  description = "The name of the Log Analytics Workspace"
  value       = module.common_services.log_analytics_name
}

output "recovery_vault_name" {
  description = "The name of the Recovery Services Vault"
  value       = module.common_services.recovery_vault_name
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = module.common_services.storage_account_name
}

output "linux_vm_hostnames" {
  value = module.linux_vms.vm_hostnames
}

output "linux_vm_private_ips" {
  value = module.linux_vms.vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.linux_vms.vm_public_ips
}

output "linux_vm_dns_names" {
  value = module.linux_vms.vm_dns_names
}

output "windows_vm_hostname" {
  value = module.windows_vm.vm_hostname
}

output "windows_vm_private_ip" {
  value = module.windows_vm.vm_private_ip
}

output "windows_vm_public_ip" {
  value = module.windows_vm.vm_public_ip
}

output "windows_vm_dns_name" {
  value = module.windows_vm.vm_dns_name
}

output "datadisk_names" {
  value = module.datadisks.disk_names
}

output "load_balancer_name" {
  description = "The name of the load balancer"
  value       = module.loadbalancer.load_balancer_name
}
