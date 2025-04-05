variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "vm_names" {
  description = "Map of VM names to their IDs"
  type        = map(string)
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
