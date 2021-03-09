resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = var.lbproberesourcegroupname
  loadbalancer_id     = var.lbprobeloadbalancerid
  name                = var.lbprobename
  protocol            = var.lbprobeprotocol
  port                = var.lbprobeport
  interval_in_seconds = var.lbprobeintervalinseconds
  number_of_probes    = var.lbprobenumberofprobes
}

output "id" {
  value = azurerm_lb_probe.lb_probe.id

}
