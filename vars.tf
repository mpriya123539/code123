variable "resourcegrouplocation" {
  type    = string
  default = "westeurope"
}
variable "resourcegroupname" {
  type    = string
  default = "RG-Networking-Demo"
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
}
variable "vnettags" {
  description = "Default tags to apply on the resource"
  type        = map
  default = {
    terraform = "true"
  }
}















