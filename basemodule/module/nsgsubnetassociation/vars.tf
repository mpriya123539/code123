variable "subnetid" {
  type    = string
}
variable "networksecuritygroupid" {
  type    = string
}
variable "dependson" {
    default = []
    type = list(string)
  # default = ["10.0.0.0/24"]
} 