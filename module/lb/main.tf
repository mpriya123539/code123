
resource "azurerm_lb" "lbspokeweb" {
  name                = var.lbname
  location            = var.lblocation
  resource_group_name = var.lbresourcegroupname
  sku = var.lbsku
  frontend_ip_configuration {
    name                 = var.lbfrontendipconfigurationname
    private_ip_address = var.lbfrontendipconfigurationprivateipaddress
    private_ip_address_allocation = var.lbfrontendipconfigurationprivateipaddressallocation
    subnet_id = var.lbfrontendipconfigurationsubnetid
  }
}
output "id" {
    value = azurerm_lb.lbspokeweb.id

} 
