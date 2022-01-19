terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.92.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {

  diag_resource_list = var.diagnostics != null ? split("/", var.diagnostics.destination) : []
  parsed_diag = var.diagnostics != null ? {
    log_analytics_id   = contains(local.diag_resource_list, "Microsoft.OperationalInsights") ? var.diagnostics.destination : null
    storage_account_id = contains(local.diag_resource_list, "Microsoft.Storage") ? var.diagnostics.destination : null
    event_hub_auth_id  = contains(local.diag_resource_list, "Microsoft.EventHub") ? var.diagnostics.destination : null
    metric             = var.diagnostics.metrics
    log                = var.diagnostics.logs
    } : {
    log_analytics_id   = null
    storage_account_id = null
    event_hub_auth_id  = null
    metric             = []
    log                = []
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_cognitive_account" "main" {
  for_each = var.cognitive_services_types

  name                = "${each.value.kind}-cog"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = each.value.kind
  sku_name            = each.value.sku_name
  tags                = var.tags

  # Is required if network_acls is used. Issue registered here https://github.com/hashicorp/terraform-provider-azurerm/issues/10041
  custom_subdomain_name = each.value.custom_subdomain_name

  network_acls {
    default_action = var.network_acls.default_action
    ip_rules = var.network_acls.ip_rules
    virtual_network_rules {
      subnet_id = var.network_acls.virtual_network_rules.subnet_id
      ignore_missing_vnet_service_endpoint = var.network_acls.virtual_network_rules.ignore_missing_vnet_service_endpoint
    }
  }
}

data "azurerm_monitor_diagnostic_categories" "default" {
  for_each = var.cognitive_services_types

  resource_id = azurerm_cognitive_account.main[each.key].id
}

resource "azurerm_monitor_diagnostic_setting" "cognitive-services" {
  for_each = var.cognitive_services_types

  name                           = "${var.name}-ns-diag"
  target_resource_id             = azurerm_cognitive_account.main[each.key].id
  log_analytics_workspace_id     = local.parsed_diag.log_analytics_id
  eventhub_authorization_rule_id = local.parsed_diag.event_hub_auth_id
  eventhub_name                  = local.parsed_diag.event_hub_auth_id != null ? var.diagnostics.eventhub_name : null
  storage_account_id             = local.parsed_diag.storage_account_id

  # For each available log category, check if it should be enabled and set enabled = true if it should.
  # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
  # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.default[each.key].logs
    content {
      category = log.value
      enabled  = contains(local.parsed_diag.log, "all") || contains(local.parsed_diag.log, log.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  # For each available metric category, check if it should be enabled and set enabled = true if it should.
  # All other categories are created with enabled = false to prevent TF from showing changes happening with each plan/apply.
  # Ref: https://github.com/terraform-providers/terraform-provider-azurerm/issues/7235
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.default[each.key].metrics
    content {
      category = metric.value
      enabled  = contains(local.parsed_diag.metric, "all") || contains(local.parsed_diag.metric, metric.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}
