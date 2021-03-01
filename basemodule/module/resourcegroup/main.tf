resource "azurerm_resource_group" "this" {
  name     = var.resourcegroupname
  location = var.resourcegrouplocation
  tags = local.tags
}
locals {
  dynamic_tags = {
    app_code                   = var.app_code
    app_name                   = var.app_name
    app_env                    = var.environment
    source                     = "terraform"
  }
  tags = merge(local.dynamic_tags, var.tags)
}
output "resourcegroupname" {
  description = "creates a resourcegroupname "
  value = azurerm_resource_group.this.name
  sensitive   = true
}
output "resourcegrouplocation" {
  description = "creates a resourcegrouplocation "
  value = azurerm_resource_group.this.location
  sensitive   = true
}