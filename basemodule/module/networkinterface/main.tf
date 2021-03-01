resource "azurerm_network_interface" "this" {
  name                = var.networkinterfacename
  location            = var.resourcegrouplocation
  resource_group_name = var.resourcegroupname
  ip_configuration {
    name                          = var.ipconfigurationname
    subnet_id                     = var.ipconfigurationsubnetid
    private_ip_address_allocation = var.ipconfigurationprivateipaddress
  }

}

output "applieddnsservers" {
    description = "applied_dns_servers"
    value = azurerm_network_interface.this.applied_dns_servers
} 
output "id" {
    description = "id"
    value = azurerm_network_interface.this.id
} 
output "internaldomainnamesuffix" {
    description = "internal_domain_name_suffix"
    value = azurerm_network_interface.this.internal_domain_name_suffix
} 
output "macaddress" {
    description = "mac_address"
    value = azurerm_network_interface.this.mac_address
} 
output "privateipaddress" {
    description = "private_ip_address"
    value = azurerm_network_interface.this.private_ip_address
} 
output "privateipaddresses" {
    description = "private_ip_addresses"
    value = azurerm_network_interface.this.private_ip_addresses
} 
output "virtualmachineid" {
    description = "virtual_machine_id"
    value = azurerm_network_interface.this.virtual_machine_id
} 



