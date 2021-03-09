variable "name" {
  type        = string
  default     = "hostname1"
}
variable "virtual_machine_id" {
  type        = string
  # default     = "westeurope"
}

variable "publisher" {
  type        = string
  default     = "Microsoft.Compute"
}


variable "extype" {
  type        = string
  default     = "CustomScriptExtension"
}
variable "type_handler_version" {
  type        = string
  default     = "1.8"
}

variable "scriptping" {
  type        = string
  default     = "https://sridver"
}
variable "commandToExecute" {
  type        = string
  # default     = "powershell.exe -ExecutionPolicy Unrestricted -file enable-icmp.ps1"
}


