variable "resourcegroupname" {
  description = "Name of the resource where the storage will be created"
  type        = string
  # default     = "kubernetes-demo"
      default = "cdashub"
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
  default     = "2016-Datacenter"
}
variable "vmosdiskstorageaccounttype" {
  type        = string
  default     = "Standard_LRS"
}
variable "vmosdiskcaching" {
  type        = string
  default     = "ReadWrite"
}

variable "vmname" {
  type        = string
  default     = "azwsserver"
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
variable "vmcount" {
  type        = number
  default = 2

}
variable "availabilitysetid" {
  type        = string

}

variable "networkinterfacename" {
  type        = string
  default     = "azwsserver-NIC"
}
variable "ipconfigurationname" {
  type        = string
  default     = "IPConfig1"
}
variable "ipconfigurationsubnetid" {
  type        = string
  # default     = "Production"
}
variable "ipconfigurationprivateipaddress" {
  type        = string
  default     =  "dynamic"
}

