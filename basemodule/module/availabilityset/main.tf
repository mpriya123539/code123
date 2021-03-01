
resource "azurerm_availability_set" "avset" {
    name = var.availabilitysetname
    platform_fault_domain_count = var.availabilitysetfaultdomaincount
    platform_update_domain_count = var.availabilitysetupdatedomaincount 
    resource_group_name = var.resourcegroupname
    location = var.availabilitysetlocation
    managed = var.managed
}


output "id" {
    value = azurerm_availability_set.avset.id

} 

