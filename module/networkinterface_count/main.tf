resource "azurerm_network_interface" "this" {
  name                = var.networkinterfacename
  location            = var.resourcegrouplocation
  resource_group_name = var.resourcegroupname
  count = var.vmcount
  ip_configuration {
    name                          = var.ipconfigurationname
    subnet_id                     = var.ipconfigurationsubnetid
    private_ip_address_allocation = var.ipconfigurationprivateipaddress
  }

}


output "id" {
    description = "id"
    value = azurerm_network_interface.this.*.id
} 



