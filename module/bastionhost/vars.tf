variable "resourcegroupname" {
  type    = string
  default = "cdashub"
}
variable "resourcegrouplocation" {
  type    = string
  default = "eastus"
  
}

variable "publicipname" {
  type    = string
  default =  "demobastion"
}

variable "ipconfigurationname" {
  type    = string
  default = "configuration"
} 
variable "ipconfigurationsubnetid" {
  type    = string
} 

variable "ipconfigurationpublicipaddressid" {
  type    = string
} 

