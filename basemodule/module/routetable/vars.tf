
variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "resourcegroupnamelocation" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "azurermroutetablename" {
  type        = string
  # default     = "cdasvnet"
} 
variable "routedependson" {
     default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 