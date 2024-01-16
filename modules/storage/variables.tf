variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "allowed_ip_range" {}
variable "virtual_network_subnet_ids" {}
variable "account_tier" { default = "Standard" }
variable "account_replication_type" { default = "LRS" }
variable "network_rules_bypass" { default = ["AzureServices"] }
variable "network_rules_default_action" { default = "Deny" }

variable "default_tags" {
  type        = map(any)
  description = "Tag for the azure resources"
}