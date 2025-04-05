variable "location" {
  description = "Azure region"
  default     = "Canada Central"
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "n01514804-RG"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default = {
    Assignment    = "CCGC 5502 Automation Assignment"
    Name          = "hunny.shah"
    ExpirationDate = "2024-12-31"
    Environment   = "Learning"
  }
}