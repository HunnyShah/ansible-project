variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = map(number)
  default     = {
    "ssh"  = 22
    "rdp"  = 3389
    "winrm" = 5985
    "http"  = 80
  }
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
