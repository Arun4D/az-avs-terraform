
variable "resource_group_name" {
  default     = ""
  description = "resource_group rg name."
}

variable "subnet_name" {
  default     = "mySubnet"
  description = "Subnet name"
}

variable "address_prefixes" {
  default     = ["10.0.1.0/24"]
  type        = list(string)
  description = "Subnet address prefixes."
}

variable "virtual_network_name" {}