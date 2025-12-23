resource "azurerm_resource_group" "task" {
  name = var.resource-group
  location = var.location
}

resource "azurerm_virtual_network" "task" {
  name = "${var.resource-group}-vnet"
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.task.location
  resource_group_name = azurerm_resource_group.task.name
}