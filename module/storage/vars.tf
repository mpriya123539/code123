variable "resourcegrouplocation" {
  type    = string
    default = "eastus"
}
variable "resourcegroupname" {
  type    = string
      default = "cdashub"
}
variable "storagereplicationtype" {
  type        = string
  default =  "LRS" 
}
variable "storageaccounttier" {
  type        = string
  default = "Standard"
}
variable "storagename" {
  type        = string
}

variable "storageenablehttpstrafficonly" {
  type        = bool
  default = true
}
variable "storageallowblobpublicaccess" {
  type        = bool
  default = true
}

