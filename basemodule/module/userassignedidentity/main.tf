resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = var.resourcegroupname
  location            = var.resourcegrouplocation
  tags = local.tags
  name = var.userassignedidentityname
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

output "id" {
    description = "id"
    value = azurerm_user_assigned_identity.this.id
} 
output "principalid" {
    description = "principal_id"
    value = azurerm_user_assigned_identity.this.principal_id
} 
output "clientid" {
    description = "client_id"
    value = azurerm_user_assigned_identity.this.client_id
} 