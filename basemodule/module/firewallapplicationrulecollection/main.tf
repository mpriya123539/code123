resource "azurerm_firewall_application_rule_collection" "azfirewall-apprules" {
  name                = var.firewallapplicationname
  azure_firewall_name = var.firewallapplicationazurefirewallname
  resource_group_name = var.resourcegroupname
  priority            = var.firewallapplicationpriority
  action              = var.firewallapplicationaction
  rule {
    name = var.firewallapplicationrulename
    source_addresses =var.firewallapplicationrulesourceaddresses
    target_fqdns =var.firewallapplicationruletargetfqdns
    protocol {
      port = "443"
      type = "Https"
    }
    protocol {
      port = "80"
      type = "Http"
    }
  }
}
output "id" {
    value = azurerm_firewall_application_rule_collection.azfirewall-apprules.id
} 
output "name" {
    value = azurerm_firewall_application_rule_collection.azfirewall-apprules.name
} 
