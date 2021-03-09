resource "azurerm_firewall" "azfirewall" {
  name                = var.firewallname
  location            = var.resourcegrouplocation
  resource_group_name = var.resourcegroupname
  depends_on =  [var.firewalldependson]
 #var.firewalldependson
    ip_configuration {
    name                 = var.firewallipconfigurationname
    subnet_id            = var.firewallipconfigurationsubnetid
    public_ip_address_id = var.firewallipconfigurationpublicipaddressid
  }
}
output "id" {
    value = azurerm_firewall.azfirewall.id
} 
output "name" {
    value = azurerm_firewall.azfirewall.name
} 
