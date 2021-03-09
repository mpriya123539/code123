variable "lbproberesourcegroupname" {
  type    = string
      default = "cdashub"
}
variable "lbprobeloadbalancerid" {
  type        = string
}
variable "lbprobename" {
  type        = string
   default = "tcpProbe"
}
variable "lbprobeprotocol" {
  type    = string
    default = "tcp"
}
variable "lbprobeport" {
  type        = number
  default = 80
}
variable "lbprobeintervalinseconds" {
  type        = number
  default = 5
}
variable "lbprobenumberofprobes" {
  type        = number
  default = 2
}

