variable "loganalyticsworkspaceName" {
  type    = string
  default = "netdemo-loganalytics"
}
variable "loganalyticsworkspacesku" {
  type    = string
  default = "PerGB2018"
}
variable "loganalyticsworkspaceretentionindays" {
  type    = string
  default = 30
}

variable "resourcegroupname" {
  type    = string
      default = "cdashub"
}
variable "resourcegrouplocation" {
  type    = string
    default = "eastus"

}

