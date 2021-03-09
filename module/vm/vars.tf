variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
      default = "cdashub"
  # default     = "kubernetes-demo"
}
variable "resourcegrouplocation" {
  description = "One of the Azure region for the resource provisioning"
  type        = string
  # default     = "westeurope"
    default = "eastus"
}



variable "vmversion" {
  type        = string
  default     = "latest"
}
variable "vmpublisher" {
  type        = string
  default     = "MicrosoftWindowsServer"
}
variable "vmoffer" {
  type        = string
  default     = "WindowsServer"
}

variable "vmsku" {
  type        = string
  default     =  "2019-Datacenter"
}
variable "vmosdiskstorageaccounttype" {
  type        = string
  default     = "Standard_LRS"
}
variable "vmosdiskcaching" {
  type        = string
  default     = "ReadWrite"
}
variable "vmnetworkinterfaceids" {
  type        = list(string)

}
variable "vmname" {
  type        = string
  default     = "azmngserver1"
}
variable "vmsize" {
  type        = string
  default     = "Standard_F2"
}
variable "vmadminusername" {
  type        = string
  default     = "adminuser"
}
variable "vmadminpassword" {
  type        = string
  default     = "P@$$w0rd1234!"
}


 
