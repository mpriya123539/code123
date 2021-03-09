variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
    default = "cdashub"
}
variable "networkwatcherflowlognetworkwatchername" {
  type        = string
}
variable "networkwatcherflowlognetworksecuritygroupid" {
  type        = string
}
variable "networkwatcherflowlogstorageaccountid" {
  type        = string
}
variable "networkwatcherflowlogenabled" {
  type        = bool
}  
variable "networkwatcherflowlogretentionpolicyenabled" {
  type        = bool
}
variable "networkwatcherflowlogretentionpolicydays" {
  type        = string
}
variable "networkwatcherflowlogtrafficanalyticsenabled" {
  type        = bool
}
variable "networkwatcherflowlogtrafficanalyticsworkspaceid" {
  type        = string
}
variable "networkwatcherflowlogtrafficanalyticsworkspaceregion" {
  type        = string
}
variable "networkwatcherflowlogtrafficanalyticsworkspaceresourceid" {
  type        = string
}

