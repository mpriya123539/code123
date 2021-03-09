

resource "azurerm_network_security_group" "nsgmgmt" {
  name                =  var.nsgname
  location            = var.nsglocation
  resource_group_name = var.resourcegroupname
}
output "id" {
    value = azurerm_network_security_group.nsgmgmt.id

} 

output "name" {
    value = azurerm_network_security_group.nsgmgmt.name

} 

