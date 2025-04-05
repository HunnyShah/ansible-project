variable "prefix" {
  description = "Prefix for resources"
  type        = string
}

variable "location" {
  description = "Azure location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the PostgreSQL instance will be created"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the PostgreSQL instance"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the PostgreSQL instance"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
