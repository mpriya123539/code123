resource "azurerm_bastion_host" "pubip" {
  name                = var.publicipname
  resource_group_name = var.resourcegroupname
  location            = var.resourcegrouplocation
 ip_configuration {
    name                 = var.ipconfigurationname
    subnet_id            = var.ipconfigurationsubnetid
    public_ip_address_id = var.ipconfigurationpublicipaddressid
  }

}

output "id" {
  value = azurerm_bastion_host.pubip.id
}

output "dns_name" {
  value = azurerm_bastion_host.pubip.dns_name
}

