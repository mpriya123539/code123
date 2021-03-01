variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string

}
variable "availabilitysetname" {
  type        = string
}
variable "availabilitysetfaultdomaincount" {
  type        = string
}
variable "availabilitysetupdatedomaincount" {
  type        = string
}
variable "availabilitysetlocation" {
  type        = string
}
variable "managed" {
  type        = string
}

