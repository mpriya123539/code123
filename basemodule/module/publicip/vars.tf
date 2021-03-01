variable "resourcegroupname" {
  type    = string
}
variable "resourcegrouplocation" {
  type    = string
}
variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)
  default = {
    environment = "AIMS-LAB"
  }
}
variable "publicipname" {
  type    = string
}
variable "publicipsku" {
  type    = string
}

variable "publicallocationmethod" {
  type    = string
} 