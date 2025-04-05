output "disk_names" {
  description = "Names of the attached data disks"
  value       = { for k, v in azurerm_managed_disk.datadisk : k => v.name }
}

