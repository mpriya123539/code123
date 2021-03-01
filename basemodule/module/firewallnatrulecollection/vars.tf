
variable "firewallnatrulename" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnatruleazure_firewall_name" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnatruleaction" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnatrulepriority" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnatrule_rulename" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallnatrulesourceaddresses" {
  type        = list(string)
  # default     = "cdasvnet"
} 
variable "firewallnatruledestinationports" {
  type        = list(string)
  # default     = "westeurope"
}
variable "firewallnatruledestinationaddresses" {
  type        = list(string)
  # default     = "kubernetes-demo"
}
variable "firewallnatruleprotocols" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
}
variable "firewallnatruletranslatedaddress" {
  type    = string
  # default = ["10.0.0.0/24"]
} 
variable "firewallnatruletranslatedport" {
  type    = string
  # default = ["10.0.0.0/24"]
} 