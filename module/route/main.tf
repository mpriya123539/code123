resource "azurerm_route" "route" {
  name                = var.routename
  resource_group_name = var.resourcegroupname
  route_table_name    = var.routeroutetablename
  address_prefix      = var.routeaddressprefix
  next_hop_type       = var.routenexthoptype
  next_hop_in_ip_address = var.routenexthopinipaddress
  depends_on = [var.routedependson]
}
output "id" {
    value = azurerm_route.route.id
} 
