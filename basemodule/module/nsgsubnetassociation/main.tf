resource "azurerm_subnet_network_security_group_association" "nsgmgmtsubnet" {
  subnet_id                 = var.subnetid
  network_security_group_id = var.networksecuritygroupid
  depends_on=[var.dependson]
  
}

output "id" {
  value = azurerm_subnet_network_security_group_association.nsgmgmtsubnet.id
  sensitive   = true
}