resource "azurerm_log_analytics_workspace" "account" {
  name                = var.loganalyticsworkspaceName
  location            = var.resourcegrouplocation
  resource_group_name = var.resourcegroupname
  sku                 = var.loganalyticsworkspacesku
  retention_in_days   = var.loganalyticsworkspaceretentionindays

}

output "id" {
    value = azurerm_log_analytics_workspace.account.id

} 
output "primary_shared_key" {
    value = azurerm_log_analytics_workspace.account.primary_shared_key

} 

output "secondary_shared_key" {
    value = azurerm_log_analytics_workspace.account.secondary_shared_key

} 
output "workspace_id" {
    value = azurerm_log_analytics_workspace.account.workspace_id

} 
output "location" {
    value = var.resourcegrouplocation

} 