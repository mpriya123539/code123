variable "network_interface_id" {
  type        = list(string)
  # default     = "kubernetes-demo"
}

variable "ip_configuration_name" {
  type        = string
  default     = "IPConfig1"
}

variable "backend_address_pool_id" {
  type        = string
  # default     = "kubernetes-demo"
}

variable "lbcount" {
  type        = number
  default     = 2
}
variable "dependson" {
  type        = list(string)
  # default     = "kubernetes-demo"
}

