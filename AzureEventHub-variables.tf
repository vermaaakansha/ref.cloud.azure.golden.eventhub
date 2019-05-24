# Reference https://www.terraform.io/docs/providers/azurerm/r/eventhub.html

#Resource Groups
variable "rg-for-active-event-hub-namespace" {
  description = "The name of the resource group which is created for active Event Hub Namespace."
  default     = ""
}

variable "vnet-resource-group-name" {
  description = "Specifies the name of the resource group in which the Virtual Network is located"
  default     = ""
}

variable "rg-for-passive-event-hub-namespace" {
  description = "The name of the resource group which is created for passive Event Hub Namespace"
  default     = ""
}

#Event Hub Namespace Active and Passive (Primary and Secondary)
variable "event-hub-namespace-active" {
  description = "Name of the active Event Hub Namespace"
  default     = ""
}

variable "event-hub-namespace-passive" {
  description = "Name of the passive Event Hub Namespace"
  default     = ""
}

#Variable for Event Hub
variable "event-hub-name" {
  description = "The name of the Event Hub"
  default     = ""
}

#Variable required for Geo-Recovery
variable "geo-recovery-alias-name" {
  description = "Name of the Alias Name for geo-disaster recovery"
  default     = ""
}

#Variables required for Firewall and Vnet
variable "vnet-name" {
  description = "Specifies the name of the Virtual Network"
  default     = ""
}

variable "subnet-name" {
  description = "Name of the Virtual Network Subnet"
  default     = ""
}

variable "iprule" {
  description = "Provide IP ranges to allow access from the internet"
  default = ""
}

#Other required Variables
variable "sku" {
  description = "Specifies SKU namespace - Standard/Basic"
  default     = "Standard"
}

variable "capacity" {
  description = "Specifies the Capacity / Throughput Unit for a Standard SKU namespace"
  default     = 2
}

variable "kafka-enabled" {
  description = "Is Kafka enabled for the EventHub Namespace?"
  default     = false
}

variable "partition-count" {
  description = "Specifies the current number of shards on the Event Hub"
  default     = "2"
}

variable "message-retention" {
  description = "Specifies the number of days to retain the events for this Event Hub. Needs to be between 1 and 7 days"
  default     = "2"
}

#Variables required for Namespace Authorization Rules
variable "namespace-authorization-rules" {
  description = "Creating three default rules for Event Hub Namespace" 
  type = "list"
  default = [
    { name = "send-only-auth-rule", listen = false, send = true, manage = false },
    { name = "listen-only-auth-rule", listen = true, send = false, manage = false },
    { name = "manage-auth-rule", listen = true, send = true, manage = true }
  ]
}


#Variables required for EventHub Authorization Rules

variable "event-hub-authorization-rules" {
  description = "Creating three default rules for Event Hub" 
  type = "list"
  default = [
    { name = "send-only-auth-rule", listen = false, send = true, manage = false },
    { name = "listen-only-auth-rule", listen = true, send = false, manage = false },
    { name = "manage-auth-rule", listen = true, send = true, manage = true }
  ]
}
