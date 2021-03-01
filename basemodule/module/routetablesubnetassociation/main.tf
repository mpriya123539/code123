
resource "azurerm_subnet_route_table_association" "routetableassociation" {
  subnet_id      = var.subnetid
  route_table_id = var.routetableid
  depends_on = [var.routedependson]
}
output "id" {
    value = azurerm_subnet_route_table_association.routetableassociation.id
} 
