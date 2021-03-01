resource "random_id" "randomId" {
    keepers = {
        resource_group = var.resourcegroupname
    }  
    byte_length = var.byte_length
}
output "hex" {
    value = random_id.randomId.hex

} 