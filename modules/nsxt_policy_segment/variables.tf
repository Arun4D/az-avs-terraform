variable "config" {}

variable "segment_tenant" {
  type    = string
  default = "Unlisted"
}

variable "segment_names" {
  description = "Segment Names for main.tf"
  type        = list(string)
}

variable "segment_IPs" {
  description = "CIDR Blocks example: 10.100.1.1/24"
  type        = list(string)
}

variable "connectivity_path" {}
variable "transport_zone_path" {}
variable "replication_mode" {}

variable "default_tags" {
  type = map(any)
}