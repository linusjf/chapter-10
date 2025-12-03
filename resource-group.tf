#
# Creates a resource group for FlixTube in your Azure account.
#
resource "azurerm_resource_group" "flixtube" {
  name     = local.app_name
  location = var.location
}
