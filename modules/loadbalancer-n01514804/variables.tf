variable "resource_group_name" {
  description = "The name of the resource group in which the load balancer will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the load balancer will be created."
  type        = string
}

variable "prefix" {
  description = "Prefix to use for resource names."
  type        = string
}

variable "linux_nic_ids" {
  description = "List of network interface IDs for the Linux VMs to be included in the load balancer."
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID for the private load balancer"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the network resources"
  type        = map(string)
}
