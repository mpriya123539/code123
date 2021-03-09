
variable "firewallapplicationname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
  default = "cdashub"
}
variable "firewallapplicationazurefirewallname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallapplicationpriority" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallapplicationaction" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallapplicationrulename" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallapplicationrulesourceaddresses" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "firewallapplicationruletargetfqdns" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 

