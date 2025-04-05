variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "availability_set_name" {
  description = "Availability set name"
  type        = string
}

variable "vm_name" {
  description = "Windows VM name"
  type        = string
  default     = "n01514804-winvm"
}

variable "vm_count" {
  description = "Number of Windows VMs"
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
}

variable "boot_diagnostics_storage_uri" {
  description = "Storage account URI for boot diagnostics"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
