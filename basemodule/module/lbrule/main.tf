resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = var.lbruleresourcegroupname
  loadbalancer_id                = var.lbruleloadbalancerid
  name                           = var.lbrulename
  protocol                       = var.lbruleprotocol
  frontend_port                  = var.lbrulefrontendport
  backend_port                   = var.lbrulebackendport
  frontend_ip_configuration_name = var.lbrulefrontendipconfigurationname
  enable_floating_ip             = var.lbruleenablefloatingip
  backend_address_pool_id        = var.lbrulebackendaddresspoolid
  idle_timeout_in_minutes        = var.lbruleidletimeoutinminutes
  probe_id                       = var.lbruleprobeid
  depends_on                     = [var.lbruledependson]
}
output "id" {
    value = azurerm_lb_rule.lb_rule.id

} 
