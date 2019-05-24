resource "azurerm_eventhub_namespace" "event-hub-namespace-1" {
  name                = "${var.event-hub-namespace-active}"
  location            = "${data.azurerm_resource_group.rg-for-active-event-hub-namespace.location}"
  resource_group_name = "${data.azurerm_resource_group.rg-for-active-event-hub-namespace.name}"
  sku                 = "${var.sku}"
  capacity            = "${var.capacity}"
  kafka_enabled       = "${var.kafka-enabled ? true : false}"
}

resource "azurerm_eventhub_namespace_authorization_rule" "event-hub-namespace-authrule" {
  count               = "${length(var.namespace-authorization-rules)}"
  depends_on          = ["azurerm_eventhub_namespace.event-hub-namespace-1"]
  name                = "${lookup(var.namespace-authorization-rules[count.index], "name")}"
  namespace_name      = "${var.event-hub-namespace-active}"
  resource_group_name = "${data.azurerm_resource_group.rg-for-active-event-hub-namespace.name}"
  listen = "${lookup(var.namespace-authorization-rules[count.index], "listen")}"
  send   = "${lookup(var.namespace-authorization-rules[count.index], "send")}"
  manage = "${lookup(var.namespace-authorization-rules[count.index], "manage")}"
}

resource "azurerm_template_deployment" "template-for-vnet-and-firewall" {
  count      = "${var.subnet-name != "" ? 1 : 0}"
  depends_on = ["azurerm_eventhub_namespace.event-hub-namespace-1"]

  name                = "namespace-network-rule-set"
  resource_group_name = "${var.rg-for-active-event-hub-namespace}"

  template_body   = "${file("${path.module}/firewall-and-vnet.json")}"
  deployment_mode = "Incremental"

  parameters = {
    eventhubNamespaceName = "${var.event-hub-namespace-active}"
    subnetId              = "${data.azurerm_subnet.subnet-with-service-endpoint.id}"
    iprule                = "${var.iprule}"
  }
}

resource "azurerm_eventhub" "event-hub" {
  depends_on          = ["azurerm_eventhub_namespace.event-hub-namespace-1"]
  name                = "${var.event-hub-name}"
  namespace_name      = "${var.event-hub-namespace-active}"
  resource_group_name = "${data.azurerm_resource_group.rg-for-active-event-hub-namespace.name}"
  partition_count     = "${var.partition-count}"
  message_retention   = "${var.message-retention}"
}

resource "azurerm_eventhub_authorization_rule" "event-hub-authrule" {
  count               = "${length(var.event-hub-authorization-rules)}"
  depends_on          = ["azurerm_eventhub.event-hub"]
  name                = "${lookup(var.event-hub-authorization-rules[count.index], "name")}"
  namespace_name      = "${var.event-hub-namespace-active}"
  eventhub_name      = "${var.event-hub-name}"
  resource_group_name = "${data.azurerm_resource_group.rg-for-active-event-hub-namespace.name}"
  listen = "${lookup(var.event-hub-authorization-rules[count.index], "listen")}"
  send   = "${lookup(var.event-hub-authorization-rules[count.index], "send")}"
  manage = "${lookup(var.event-hub-authorization-rules[count.index], "manage")}"
}
