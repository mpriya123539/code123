resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  address_space       = var.virtualnetworkvnetaddressspace
  location            = var.resource_group_location
  resource_group_name = var.resourcegroupname
} 

output "id" {
    description = "azurerm vnet id"
    value = azurerm_virtual_network.vnet.id

} 

output "name" {
    description = "azurerm vnet name"
    value = azurerm_virtual_network.vnet.name

}

