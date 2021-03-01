variable "frontdoorname" {
  type    = string
}
variable "location" {
  type    = string
}
variable "resource_group_name" {
  type    = string
}
variable "enforce_backend_pools_certificate_name_check" {
  type    = bool
}

variable "routing_rulename" {
  type    = string
}
variable "routing_ruleaccepted_protocols" {
  type    =  list(string)
}


variable "routing_rulepatterns_to_match" {
  type    =  list(string)
}
variable "routing_rulefrontend_endpoints" {
  type    = list(string)
}


variable "routing_ruleforwarding_protocol" {
  type    = string
}
variable "routing_rulebackend_pool_name" {
  type    = string
}




variable "backend_pool_load_balancingname" {
  type    = string
}
variable "backend_pool_health_probename" {
  type    = string
}
variable "backend_poolname" {
  type    = string
}
variable "backend_poolhost_header" {
  type    = string
}

variable "backend_pooladdress" {
  type    = string
}
variable "backend_poolhttp_port" {
  type    = number
}
variable "backend_poolhttps_port" {
  type    = number
}

variable "load_balancing_name" {
  type    = string
}
variable "health_probe_name" {
  type    = string
}


variable "frontend_endpointname" {
  type    = string
}

variable "frontend_endpointhost_name" {
  type    = string
}
variable "frontend_endpointcustom_https_provisioning_enabled" {
  type    = bool
}