variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
  # default     = "kubernetes-demo"
}

variable "vnet" {
  type        = string
  # default     = "cdasvnet"
} 
variable "virtualnetworkvnetaddressspace" {
  type    = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "subnet" {
  type        = string
  # default     = "cdassubnet"
} 

