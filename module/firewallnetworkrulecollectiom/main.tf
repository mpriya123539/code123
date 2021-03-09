resource "azurerm_firewall_network_rule_collection" "azfirewall-netrules" {
  name                = var.firewallnetworkname
  azure_firewall_name = var.firewallnetworkazurefirewallname
  resource_group_name = var.resourcegroupname
  priority            = var.firewallnetworkpriority
  action              = var.firewallnetworkaction
  rule {
    name = var.firewallnetworkrulename
    source_addresses = var.firewallnetworkrulesourceaddresses
    destination_ports =var.firewallnetworkruledestinationports
    destination_addresses = var.firewallnetworkruledestinationaddresses
    protocols = var.firewallnetworkruleprotocols
  }
}

output "id" {
  value = azurerm_firewall_network_rule_collection.azfirewall-netrules.id

}