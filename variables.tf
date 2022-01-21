variable "name" {
  description = "Name of the cognitive service."
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "The Azure Region in which to create resource."
}

variable "cognitive_services_types" {
  description = "List of cognitive services to create. Possible values for kind and sku_name can be viewed in README.md. The subdomain name used for token-based authentication. Changing this forces a new resource to be created"
  type = map(object({
    kind                  = string
    sku_name              = string
    custom_subdomain_name = string
  }))
  default = {}
}

variable "network_acls" {
  description = "Configure ip filtering. Define IP Addresses, or CIDR Blocks which should be able to access the Cognitive Account."
  type = object({
    default_action = string
    ip_rules       = list(string)
    virtual_network_rules = object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = bool
    })
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it. See README.md for details on configuration."
  type = object({
    destination   = string
    eventhub_name = string
    logs          = list(string)
    metrics       = list(string)
  })
  default = null
}
