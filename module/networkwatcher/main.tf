
resource "azurerm_network_watcher" "watcher" {
  name                = var.networkwatchername
  location            = var.networkwatcherlocation
  resource_group_name = var.resourcegroupname
}

output "id" {
    value = azurerm_network_watcher.watcher.id

} 

output "name" {
    value = azurerm_network_watcher.watcher.name

} 

