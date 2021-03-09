variable "lbname" {
  type    = string
}
variable "lblocation" {
  type    = string
    default = "eastus"
}
variable "lbresourcegroupname" {
  type        = string
    default = "cdashub"

}
variable "lbsku" {
  type        = string
}
variable "lbfrontendipconfigurationname" {
  type        = string
}
variable "lbfrontendipconfigurationprivateipaddress" {
  type        = string
}
variable "lbfrontendipconfigurationprivateipaddressallocation" {
  type        = string
}
variable "lbfrontendipconfigurationsubnetid" {
  type        = string
}

