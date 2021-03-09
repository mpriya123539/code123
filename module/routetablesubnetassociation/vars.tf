
variable "subnetid" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "routetableid" {
  type        = string
  # default     = "cdasvnet"
} 
variable "routedependson" {
     default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 