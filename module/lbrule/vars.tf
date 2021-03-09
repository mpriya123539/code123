
variable "lbruleresourcegroupname" {
  type    = string
      default = "cdashub"
}
variable "lbruleloadbalancerid" {
  type        = string
}
variable "lbrulename" {
  type        = string
  default = "LBRule"
}


variable "lbruleprotocol" {
  type    = string
  default = "tcp"
}
variable "lbrulefrontendport" {
  type        = string
  default = 80
}
variable "lbrulebackendport" {
  type        = string
  default = 80
}


variable "lbrulefrontendipconfigurationname" {
  type    = string
  default =  "PrivateIPAddress"
}
variable "lbruleenablefloatingip" {
  type        = bool
  default = false
}
variable "lbrulebackendaddresspoolid" {
  type        = string
}


variable "lbruleidletimeoutinminutes" {
  type    = number
  default = 5
}
variable "lbruleprobeid" {
  type        = string
}
variable "lbruledependson" {
    default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 
