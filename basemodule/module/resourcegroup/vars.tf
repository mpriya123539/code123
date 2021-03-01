variable "resourcegrouplocation" {
  type    = string
}
variable "resourcegroupname" {
  type    = string
}
variable "app_name" {
  type        = string
}
variable "app_code" {
  type        = string
}
variable "environment" {
  type        = string
}
variable "tags" {
  description = "Default tags to apply on the resource"
  type        = map
}