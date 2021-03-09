variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
  default = "cdashub"

}
variable "availabilitysetname" {
  type        = string
  default = "vmavset-spokevm"
}
variable "availabilitysetfaultdomaincount" {
  type        = number
  default = 3
}
variable "availabilitysetupdatedomaincount" {
  type        = number
  default = 5
}
variable "availabilitysetlocation" {
  type        = string
    default = "eastus"
}
variable "managed" {
  type        = bool
  default = true
}

