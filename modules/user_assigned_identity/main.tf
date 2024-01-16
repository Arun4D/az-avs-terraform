# Create (and display) an SSH key
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = "user-assigned-identity"
  location            = var.config["location"]
  resource_group_name = var.resource_group_name
}