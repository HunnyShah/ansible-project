variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
  default     = "Canada Central"
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
