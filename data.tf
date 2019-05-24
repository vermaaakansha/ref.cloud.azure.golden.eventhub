
data "azurerm_subnet" "subnet-with-service-endpoint" {
  count                = "${var.subnet-name != "" ? 1 : 0}"
  name                 = "${var.subnet-name}"
  virtual_network_name = "${var.vnet-name}"
  resource_group_name  = "${var.vnet-resource-group-name}"
}

data "azurerm_resource_group" "rg-for-active-event-hub-namespace" {
  name = "${var.rg-for-active-event-hub-namespace}"
}

data "azurerm_resource_group" "rg-for-passive-event-hub-namespace" {
  count = "${var.rg-for-passive-event-hub-namespace != "" ? 1 : 0}"
  name  = "${var.rg-for-passive-event-hub-namespace}"
}
