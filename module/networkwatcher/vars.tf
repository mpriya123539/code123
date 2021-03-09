variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
    default = "cdashub"
}
variable "networkwatchername" {
  type        = string
  default = "demo-nwwatcher"
}
variable "networkwatcherlocation" {
  type        = string
    default = "eastus"
}
