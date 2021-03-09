
variable "firewallnetworkname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnetworkazurefirewallname" {
  type        = string
  # default     = "cdasvnet"
} 

variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
    default = "cdashub"

}
variable "firewallnetworkpriority" {
  type        = string
  # default     = "westeurope"
}

variable "firewallnetworkaction" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnetworkrulename" {
  type        = string
  # default     = "westeurope"
}

variable "firewallnetworkrulesourceaddresses" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "firewallnetworkruledestinationports" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "firewallnetworkruledestinationaddresses" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "firewallnetworkruleprotocols" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 
