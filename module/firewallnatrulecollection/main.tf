resource "azurerm_firewall_nat_rule_collection" "fd2fwnat" {
  name                =  var.firewallnatrulename
  azure_firewall_name = var.firewallnatruleazure_firewall_name
  resource_group_name = var.resourcegroupname
  priority            = var.firewallnatrulepriority
  action              = var.firewallnatruleaction
rule {
    name = var.firewallnatrule_rulename
    source_addresses = var.firewallnatrulesourceaddresses
    destination_ports = var.firewallnatruledestinationports
    destination_addresses = var.firewallnatruledestinationaddresses
    protocols = var.firewallnatruleprotocols
    translated_address = var.firewallnatruletranslatedaddress
    translated_port = var.firewallnatruletranslatedport
}
}