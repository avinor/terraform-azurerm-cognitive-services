variable "name" {
  description = "Name of the cognitive service."
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "The Azure Region in which to create resource."
}

variable "kind" {
  description = "Specifies the type of Cognitive Service Account that should be created. Possible values can be viewed in README.md. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "Specifies the SKU Name for this Cognitive Service Account. Possible values can be viewed in README.md"
  type        = string
  default     = ""
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
