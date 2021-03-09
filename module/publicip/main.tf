resource "azurerm_public_ip" "pubip" {
  name                = var.publicipname
  resource_group_name = var.resourcegroupname
  location            = var.resourcegrouplocation
  allocation_method   = var.publicallocationmethod

   sku = var.publicipsku


}
output "ip_address" {
  value = azurerm_public_ip.pubip.ip_address
}
output "id" {
  value = azurerm_public_ip.pubip.id
}
output "fqdn" {
  value = azurerm_public_ip.pubip.fqdn
}
output "domain_name_label" {
  value = azurerm_public_ip.pubip.domain_name_label
}
