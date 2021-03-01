
resource "azurerm_network_watcher_flow_log" "watcher" {
  network_watcher_name =  var.networkwatcherflowlognetworkwatchername
  resource_group_name  = var.resourcegroupname

  network_security_group_id = var.networkwatcherflowlognetworksecuritygroupid
  storage_account_id        = var.networkwatcherflowlogstorageaccountid
  enabled                   = var.networkwatcherflowlogenabled

  retention_policy {
    enabled = var.networkwatcherflowlogretentionpolicyenabled
    days    = var.networkwatcherflowlogretentionpolicydays
  }

  traffic_analytics {
    enabled               = var.networkwatcherflowlogtrafficanalyticsenabled
    workspace_id          = var.networkwatcherflowlogtrafficanalyticsworkspaceid
    workspace_region      = var.networkwatcherflowlogtrafficanalyticsworkspaceregion
    workspace_resource_id = var.networkwatcherflowlogtrafficanalyticsworkspaceresourceid
  }
}
