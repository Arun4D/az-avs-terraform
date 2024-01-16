variable "config" {}
variable "environment" {}
variable "application" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "admin_username" {}
variable "admin_password" {}
variable "disk_encryption_set_id" {}
variable "boot_diagnostics_storage_account_uri" {}
variable "provision_vm_agent" {}
variable "user_assigned_identity" {}
variable "default_tags" {}

variable "zonal" { default = true }

