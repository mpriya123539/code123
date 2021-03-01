variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
  # default     = "kubernetes-demo"
}
variable "resource_group_location" {
  description = "One of the Azure region for the resource provisioning"
  type        = string
  # default     = "westeurope"
}
variable "vnet" {
  type        = string
  default     = "cdasvnet"
} 
variable "virtualnetworkvnetaddressspace" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
}
# variable "dynamic_tags" {
#   type = list(object({
#     allowed_headers         = list(string)
#     allowed_methods         = list(string)
#     allowed_origins         = list(string)
#     exposed_headers         = list(string)
#     max_age_in_seconds      = number
#   }))
#   # default = []
# }
