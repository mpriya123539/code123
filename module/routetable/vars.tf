
variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
      default = "cdashub"
}
variable "resourcegroupnamelocation" {
  type        = string
  # default     = "kubernetes-demo"
    default = "eastus"
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