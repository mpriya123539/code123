variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
}


variable "routename" {
  type        = string
  # default     = "cdasvnet"
} 
variable "routedependson" {
    default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "routeroutetablename" {
  type        = string
  # default     = "cdassubnet"
} 

variable "routeaddressprefix" {
  type        = string
  # default     = "cdassubnet"
} 
variable "routenexthoptype" {
  type        = string
  # default     = "cdassubnet"
} 

variable "routenexthopinipaddress" {
  type        = string
  # default     = "cdassubnet"
} 

