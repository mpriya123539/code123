
variable "lbruleresourcegroupname" {
  type    = string
}
variable "lbruleloadbalancerid" {
  type        = string
}
variable "lbrulename" {
  type        = string
}


variable "lbruleprotocol" {
  type    = string
}
variable "lbrulefrontendport" {
  type        = string
}
variable "lbrulebackendport" {
  type        = string
}


variable "lbrulefrontendipconfigurationname" {
  type    = string
}
variable "lbruleenablefloatingip" {
  type        = string
}
variable "lbrulebackendaddresspoolid" {
  type        = string
}


variable "lbruleidletimeoutinminutes" {
  type    = string
}
variable "lbruleprobeid" {
  type        = string
}
variable "lbruledependson" {
    default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 