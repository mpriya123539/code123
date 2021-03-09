resource "azurerm_lb_backend_address_pool" "lb-backendpool" {
  resource_group_name = var.resourcegroupname
  loadbalancer_id     = var.loadbalancerid
  name                = var.name
}

output "id" {
  value = azurerm_lb_backend_address_pool.lb-backendpool.id

}