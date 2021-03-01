resource "azurerm_route_table" "azurermroutetable" {
  name                = var.azurermroutetablename
  location            = var.resourcegroupnamelocation
  resource_group_name = var.resourcegroupname
  depends_on = [var.routedependson]
}
output "id" {
    value = azurerm_route_table.azurermroutetable.id
} 
output "name" {
    value = azurerm_route_table.azurermroutetable.name
} 
