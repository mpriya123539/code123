resource "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = var.resourcegroupname
  virtual_network_name = var.vnet
  address_prefixes     = var.virtualnetworkvnetaddressspace
}

output "id" {
    description = "azurerm subnet id "
    value = azurerm_subnet.subnet.id

} 

output "name" {
    description = "azurerm subnet name "
    value = azurerm_subnet.subnet.name

}

