variable "loganalyticsworkspaceName" {
  type    = string
}
variable "loganalyticsworkspacesku" {
  type    = string
}
variable "loganalyticsworkspaceretentionindays" {
  type    = string
  default = 30
}

variable "resourcegroupname" {
  type    = string
}
variable "resourcegrouplocation" {
  type    = string

}