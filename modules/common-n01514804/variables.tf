variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "azurerm_resource_group.tfstate.name"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "log_analytics_name" {
  description = "Log Analytics Workspace name"
  type        = string
}

variable "recovery_vault_name" {
  description = "Recovery Services Vault name"
  type        = string
}

variable "storage_account_name" {
  description = "Storage Account name (must be different from Terraform backend storage)"
  type        = string
  default     = "n01514804storage"
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
