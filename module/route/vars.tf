variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
      default = "cdashub"
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
  default     = "0.0.0.0/0"
} 
variable "routenexthoptype" {
  type        = string
  default     = "VirtualAppliance"
} 

variable "routenexthopinipaddress" {
  type        = string
  default     ="10.0.8.4"
} 
