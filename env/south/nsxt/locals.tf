locals {
  global_plus_env_tag = merge(var.environment_tags, var.global_tags)
  config_final        = merge(var.config, var.global_map)
}