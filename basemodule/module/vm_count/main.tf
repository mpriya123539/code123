resource "azurerm_windows_virtual_machine" "this" {
  name                = "${var.vmname}${count.index}"
  resource_group_name = var.resourcegroupname
  location            = var.resourcegrouplocation
  size                = var.vmsize
  admin_username      = var.vmadminusername
  admin_password      = var.vmadminpassword

  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  count =var.vmcount
  availability_set_id=var.availabilitysetid

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
resource "azurerm_network_interface" "nic" {
  name                = "${var.networkinterfacename}${count.index}"
  location            = var.resourcegrouplocation
  resource_group_name = var.resourcegroupname
  count = var.vmcount
  ip_configuration {
    name                          = var.ipconfigurationname
    subnet_id                     = var.ipconfigurationsubnetid
    private_ip_address_allocation = var.ipconfigurationprivateipaddress
  }

}
output "nicid" {
    description = "nicid"
    value = azurerm_network_interface.nic.*.id
} 
output "vmid" {
    description = "nicid"
    value = azurerm_windows_virtual_machine.this.*.id
} 