
resource "azurerm_frontdoor" "azfrontdoor" {
  name                                         = var.frontdoorname
  location                                     = var.location
  resource_group_name                          = var.resource_group_name
  enforce_backend_pools_certificate_name_check = var.enforce_backend_pools_certificate_name_check

  routing_rule {
    name               = var.routing_rulename
    accepted_protocols = var.routing_ruleaccepted_protocols
    patterns_to_match  = var.routing_rulepatterns_to_match
    frontend_endpoints = var.routing_rulefrontend_endpoints
    forwarding_configuration {
      forwarding_protocol = var.routing_ruleforwarding_protocol
      backend_pool_name   = var.routing_rulebackend_pool_name
    }
  }

  backend_pool_load_balancing {
    name = var.backend_pool_load_balancingname
  }

  backend_pool_health_probe {
    name = var.backend_pool_health_probename
  }

  backend_pool {
    name = var.backend_poolname
    backend {
      host_header = var.backend_poolhost_header
      address     = var.backend_pooladdress
      http_port   = var.backend_poolhttp_port
      https_port  = var.backend_poolhttps_port
    }

    load_balancing_name = var.load_balancing_name
    health_probe_name   = var.health_probe_name
  }

  frontend_endpoint {
    name                              = var.frontend_endpointname
    host_name                         = "${var.frontend_endpointhost_name}.azurefd.net"
    custom_https_provisioning_enabled = var.frontend_endpointcustom_https_provisioning_enabled
  }
}
output "id" {
  value = azurerm_frontdoor.azfrontdoor.id

}