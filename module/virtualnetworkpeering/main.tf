resource "azurerm_virtual_network_peering" "peering" {
  name                         = var.networkpeeringname 
  resource_group_name          = var.networkpeeringresourcegroup
  virtual_network_name         = var.networkpeeringvirtualnetworkname
  remote_virtual_network_id    = var.networkpeeringremotevirtualnetworkid
  allow_virtual_network_access = var.networkpeeringallowvirtualnetworkaccess
  allow_forwarded_traffic      = var.networkpeeringallowforwardedtraffic  
  allow_gateway_transit = var.networkpeeringallowgatewaytransit
   depends_on = [var.networkpeeringdependson]
}

output "id" {
    value = azurerm_virtual_network_peering.peering.id
} 