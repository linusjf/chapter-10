resource "azurerm_network_watcher" "nw" {
  name                = "NetworkWatcher_${var.location}"
  resource_group_name = azurerm_resource_group.flixtube.name
  location            = azurerm_resource_group.flixtube.location
}
