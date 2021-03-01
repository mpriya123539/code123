

resource "azurerm_virtual_network_gateway_connection" "Hub-to-Onprem-vpn" {
  name                = var.virtualnetworkgatewayconnectionname
  location            = var.location
  resource_group_name = var.resourcegroupname
  type                            = var.virtualnetworkgatewayconnectiontype
  virtual_network_gateway_id      = var.virtualnetworkgatewayconnectiongatewayid
  peer_virtual_network_gateway_id = var.virtualnetworkgatewayconnectionpeergatewayid
  shared_key = var.virtualnetworkgatewayconnectionsharedkey
}

output "id" {
    value = azurerm_virtual_network_gateway_connection.Hub-to-Onprem-vpn.id
} 
