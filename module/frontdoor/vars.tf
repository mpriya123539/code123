variable "frontdoorname" {
  type    = string
   default ="frontdoorname2061"
}
variable "location" {
  type    = string
    default = "eastus"
}
variable "resource_group_name" {
  type    = string
    default = "cdashub"
}
}
variable "enforce_backend_pools_certificate_name_check" {
  type    = bool
  default =false
}

variable "routing_rulename" {
  type    = string
  default="exampleRoutingRule1"
}
variable "routing_ruleaccepted_protocols" {
  type    =  list(string)
  default =["Http"]
}


variable "routing_rulepatterns_to_match" {
  type    =  list(string)
  default =["exampleFrontendEndpoint1"]
}
variable "routing_rulefrontend_endpoints" {
  type    = list(string)
}


variable "routing_ruleforwarding_protocol" {
  type    = string
  default =  "HttpOnly"
}
variable "routing_rulebackend_pool_name" {
  type    = string
  default = "exampleBackend"
}




variable "backend_pool_load_balancingname" {
  type    = string
  default =  "exampleLoadBalancingSettings1"
}
variable "backend_pool_health_probename" {
  type    = string
  default = "exampleHealthProbeSetting1"

}
variable "backend_poolname" {
  type    = string
  default = "exampleBackend"
}
variable "backend_poolhost_header" {
  type    = string
  default = "mytest"

}

variable "backend_pooladdress" {
  type    = string

}
variable "backend_poolhttp_port" {
  type    = number
  default = 80
}
variable "backend_poolhttps_port" {
  type    = number
  default = 443
}

variable "load_balancing_name" {
  type    = string
  default = "exampleLoadBalancingSettings1"
}
variable "health_probe_name" {
  type    = string
  default = "exampleHealthProbeSetting1"
}


variable "frontend_endpointname" {
  type    = string
  default = "exampleFrontendEndpoint1"
}

variable "frontend_endpointhost_name" {
  type    = string
  default = "frontdoorname2061"
}
variable "frontend_endpointcustom_https_provisioning_enabled" {
  type    = bool
  default = false
}