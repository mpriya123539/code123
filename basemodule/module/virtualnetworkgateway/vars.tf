variable "virtualnetworkgatewayname" {
  type    = string
  default = "vnetpeer"
}
variable "virtualnetworkgatewaylocation" {
  type    = string
  default = "vnetpeerrg"
}
variable "resourcegroupname" {
  type    = string
  default = "vlanname"
}
variable "virtualnetworkgatewaytype" {
  type    = string
  default = "vlanid"
}
variable "virtualnetworkgatewayvpntype" {
  type    = string
  default = true
}
variable "virtualnetworkgatewayactiveactive" {
  type    = string
  default = true
}
variable "virtualnetworkgatewayenablebgp" {
  type    = string
  default = false
}

variable "virtualnetworkgatewaysku" {
  type    = string
  default = "vlanid"
}
variable "virtualnetworkgatewayipname" {
  type    = string
  default = true
}
variable "virtualnetworkgatewayippublicipaddressid" {
  type    = string
  default = true
}
variable "virtualnetworkgatewayipprivateipaddressallocation" {
  type    = string
  default = false
}
variable "virtualnetworkgatewayipsubnetid" {
  type    = string
  default = false
}
