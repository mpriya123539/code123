resource "azurerm_windows_virtual_machine" "this" {
  name                = var.vmname
  resource_group_name = var.resourcegroupname
  location            = var.resourcegrouplocation
  size                = var.vmsize
  admin_username      = var.vmadminusername
  admin_password      = var.vmadminpassword

  network_interface_ids = var.vmnetworkinterfaceids
  
 
  os_disk {
    caching              = var.vmosdiskcaching
    storage_account_type = var.vmosdiskstorageaccounttype
  }

  source_image_reference {
    publisher = var.vmpublisher
    offer     = var.vmoffer
    sku       = var.vmsku
    version   = var.vmversion
  }
}

output "id" {
    description = "id"
    value = azurerm_windows_virtual_machine.this.id
} 
output "privateipaddress" {
    description = "private_ip_address"
    value = azurerm_windows_virtual_machine.this.private_ip_address
} 
output "privateipaddresses" {
    description = "private_ip_addresses"
    value = azurerm_windows_virtual_machine.this.private_ip_addresses
} 
output "publicipaddress" {
    description = "public_ip_address"
    value = azurerm_windows_virtual_machine.this.public_ip_address
} 
output "publicipaddresses" {
    description = "public_ip_addresses"
    value = azurerm_windows_virtual_machine.this.public_ip_addresses
} 
output "virtualmachineid" {
    description = "virtual_machine_id"
    value = azurerm_windows_virtual_machine.this.virtual_machine_id
} 