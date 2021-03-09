# create load balancer backend pool association with VM NICs
resource "azurerm_network_interface_backend_address_pool_association" "backendassociation" {
  network_interface_id    = element(var.network_interface_id, count.index)
 #  "${var.network_interface_id}${count.index}"
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = var.backend_address_pool_id
  count = var.lbcount
  depends_on = [var.dependson]
}




