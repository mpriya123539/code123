variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
    default = "cdashub"
}
variable "nsgname" {
  type        = string
}
variable "nsglocation" {
  type        = string
    default = "eastus"
}

