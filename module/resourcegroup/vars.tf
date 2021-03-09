variable "resourcegrouplocation" {
  type    = string
  default = "eastus"
}
variable "resourcegroupname" {
  type    = string
   default = "cdashub"
}

variable "app_code" {
  type    = string
  default = "201"
}
variable "app_name" {
  type    = string
  default = "uconnapp"
}
variable "environment" {
  type    = string
  default = "prod"
}
variable "rgtags" {
  description = "Default tags to apply on the resource"
  type        = map
  default = {
    terraform = "true"
  }
