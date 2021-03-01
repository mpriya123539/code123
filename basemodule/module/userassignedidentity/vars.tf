variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
  # default     = "kubernetes-demo"
}
variable "resourcegrouplocation" {
  description = "One of the Azure region for the resource provisioning"
  type        = string
  # default     = "westeurope"
}
variable "app_name" {
  type        = string
  # default     = "app1"
}
variable "app_code" {
  type        = string
  # default     = "202"
}
variable "environment" {
  type        = string
  # default     = "Production"
}
variable "tags" {
  description = "Default tags to apply on the resource"
  type        = map
}
variable "userassignedidentityname" {
  type        = string
  # default     = "Production"
}
