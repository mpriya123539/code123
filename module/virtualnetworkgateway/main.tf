resource "azurerm_virtual_network_gateway" "hubvpngw" {
  name                = var.virtualnetworkgatewayname
  location            = var.virtualnetworkgatewaylocation
  resource_group_name = var.resourcegroupname

  type     = var.virtualnetworkgatewaytype
  vpn_type = var.virtualnetworkgatewayvpntype

  active_active = var.virtualnetworkgatewayactiveactive
  enable_bgp    = var.virtualnetworkgatewayenablebgp
  sku           = var.virtualnetworkgatewaysku

  ip_configuration {
    name                          = var.virtualnetworkgatewayipname
    public_ip_address_id          = var.virtualnetworkgatewayippublicipaddressid
    private_ip_address_allocation = var.virtualnetworkgatewayipprivateipaddressallocation
    subnet_id                     = var.virtualnetworkgatewayipsubnetid
  }
}

output "id" {

    value = azurerm_virtual_network_gateway.hubvpngw.id

} 