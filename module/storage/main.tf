
resource "azurerm_storage_account" "this" {
  name                     = var.storagename 
  resource_group_name      = var.resourcegroupname
  location                 = var.resourcegrouplocation
  account_tier             = var.storageaccounttier 
  account_replication_type = var.storagereplicationtype  
  enable_https_traffic_only= var.storageenablehttpstrafficonly
  allow_blob_public_access=var.storageallowblobpublicaccess

}

output "id" {

  value = azurerm_storage_account.this.id
  sensitive   = true
}