variable "networkpeeringname" {
  type    = string
  default = "vnetpeer"
}
variable "networkpeeringresourcegroup" {
  type    = string
    default = "cdashub"
}
variable "networkpeeringvirtualnetworkname" {
  type    = string
  default = "vlanname"
}
variable "networkpeeringremotevirtualnetworkid" {
  type    = string
  default = "vlanid"
}
variable "networkpeeringallowvirtualnetworkaccess" {
  type    = bool
  default = true
}
variable "networkpeeringallowforwardedtraffic" {
  type    = bool
  default = true
}
variable "networkpeeringallowgatewaytransit" {
  type    = bool
  default = true
}
variable "networkpeeringdependson" {
     default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 