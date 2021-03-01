variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
  # default     = "kubernetes-demo"
}
variable "resourcegrouplocation" {
  description = "One of the Azure region for the resource provisioning"
  type        = string
  # default     = "westeurope"
}

variable "networkinterfacename" {
  type        = string
  # default     = "Production"
}
variable "ipconfigurationname" {
  type        = string
  # default     = "Production"
}
variable "ipconfigurationsubnetid" {
  type        = string
  # default     = "Production"
}
variable "ipconfigurationprivateipaddress" {
  type        = string
  # default     = "Production"
}
