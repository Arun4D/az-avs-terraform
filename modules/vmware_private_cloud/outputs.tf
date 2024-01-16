output "private_cloud_id" {
  value = azurerm_vmware_private_cloud.private_cloud.id
}
output "express_route_auth_key_id" {
  value = azurerm_vmware_express_route_authorization.express_route_auth_key.id
}
