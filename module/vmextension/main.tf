resource "azurerm_virtual_machine_extension" "exthub" {
  name                 = var.name
  virtual_machine_id   = var.virtual_machine_id
  publisher            = var.publisher
  type                 = var.extype
  type_handler_version =var.type_handler_version

  settings = <<SETTINGS
    {
    "fileUris": ["${var.scriptping}"],
    "commandToExecute": var.commandToExecute
    }
SETTINGS
}

output "id" {
    description = "id"
    value = azurerm_virtual_machine_extension.exthub.id
} 