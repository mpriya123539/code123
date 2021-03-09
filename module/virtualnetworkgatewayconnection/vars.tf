
  
variable "virtualnetworkgatewayconnection" {
  type    = string
  default = "vnetpeer"
}
variable "location" {
  type    = string
  default = "eastus"
}
variable "resourcegroupname" {
  type    = string
    default = "cdashub"
}
variable "virtualnetworkgatewayconnectiontype" {
  type    = string
  default = "vlanid"
}
variable "virtualnetworkgatewayconnectiongatewayid" {
  type    = string
  default = true
}
variable "virtualnetworkgatewayconnectionpeergatewayid" {
  type    = string
  default = true
}
variable "virtualnetworkgatewayconnectionsharedkey" {
  type    = string
  default = false
}
variable "virtualnetworkgatewayconnectionname" {
  type    = string
  default = false
}