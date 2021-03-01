
variable "firewallname" {
  type        = string
  # default     = "kubernetes-demo"
}

variable "resourcegroupname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "resourcegrouplocation" {
  type        = string
  # default     = "westeurope"
}
variable "firewalldependson" {
    default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 
variable "firewallipconfigurationname" {
  type        = string
  # default     = "kubernetes-demo"
}
variable "firewallipconfigurationsubnetid" {
  type        = string
  # default     = "westeurope"
}
variable "firewallipconfigurationpublicipaddressid" {
  type        = string
  # default     = "kubernetes-demo"
}
