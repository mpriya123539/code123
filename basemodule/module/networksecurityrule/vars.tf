variable "name" {
  description = "Name of the resource where the storage will be created"
  type        = string

}
variable "priority" {
  type        = number
}
variable "direction" {
  description = "Name of the resource where the storage will be created"
  type        = string

}
variable "access" {
  type        = string
}



variable "protocol" {
  description = "Name of the resource where the storage will be created"
  type        = string

}
variable "source_port_range" {
  type        = string
}
variable "destination_port_range" {
  description = "Name of the resource where the storage will be created"
  type        = string

}
variable "source_address_prefix" {
  type        = string
}




variable "destination_address_prefix" {
  type        = string
}
variable "resource_group_name" {
  description = "Name of the resource where the storage will be created"
  type        = string

}
variable "network_security_group_name" {
  type        = string
}

