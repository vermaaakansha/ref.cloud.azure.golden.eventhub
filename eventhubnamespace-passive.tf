

resource "azurerm_eventhub_namespace" "event-hub-namespace-2" {
  count               = "${var.event-hub-namespace-passive != "" ? 1 : 0}"
  name                = "${var.event-hub-namespace-passive}"
  location            = "${data.azurerm_resource_group.rg-for-passive-event-hub-namespace.location}"
  resource_group_name = "${data.azurerm_resource_group.rg-for-passive-event-hub-namespace.name}"
  sku                 = "${var.sku}"
  capacity            = "${var.capacity}"
  kafka_enabled       = "${var.kafka-enabled ? true : false}"
}

resource "azurerm_template_deployment" "template-for-geo-recovery" {
  count      = "${var.event-hub-namespace-passive != "" ? 1 : 0}"
  depends_on = ["azurerm_eventhub_namespace.event-hub-namespace-1", "azurerm_eventhub_namespace.event-hub-namespace-2"]

  name                = "template-for-geo-recovery"
  resource_group_name = "${var.rg-for-active-event-hub-namespace}"

  template_body   = "${file("${path.module}/geo-recovery.json")}"
  deployment_mode = "Incremental"

  parameters = {
    primaryEventHubNamespaceName   = "${var.event-hub-namespace-active}"
    primaryLocation                = "${azurerm_eventhub_namespace.event-hub-namespace-1.location}"
    secondaryEventHubNamespaceId   = "${azurerm_eventhub_namespace.event-hub-namespace-2.id}"
    aliasName                      = "${var.geo-recovery-alias-name}"
  }
}
