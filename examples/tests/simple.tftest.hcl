variables {

  name                = "cognitive-services"
  resource_group_name = "cognitive-services-rg"
  location            = "westeurope"

  cognitive_services_types = {
    face = {
      sku_name              = "F0"
      kind                  = "Face"
      custom_subdomain_name = "face-cog"
    }
    computerVision = {
      sku_name              = "F0"
      kind                  = "ComputerVision"
      custom_subdomain_name = "computer-vision-cog"
    }
  }

  network_acls = {
    default_action = "Deny"
    ip_rules       = ["10.192.180.1", "10.192.180.2"]
    virtual_network_rules = {
      subnet_id                            = "123"
      ignore_missing_vnet_service_endpoint = false
    }
  }

  diagnostics = {
    destination   = "/subscriptions/000000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.EventHub/namespaces/namespaceValue/authorizationRules/authorizationRuleValue"
    eventhub_name = null
    logs          = ["RequestResponse"]
    metrics       = []
  }

  tags = {
    tag1 = "value1"
  }

}

run "simple" {
  command = plan

  # Face Cognitive Service
  assert {
    condition     = azurerm_cognitive_account.main["face"].name == "Face-cog"
    error_message = "Cognitive account name did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["face"].location == "westeurope"
    error_message = "Cognitive account location did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["face"].resource_group_name == "cognitive-services-rg"
    error_message = "Cognitive account resource group did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["face"].kind == "Face"
    error_message = "Cognitive account kind did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["face"].sku_name == "F0"
    error_message = "Cognitive account SKU did not match expected"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.cognitive-services["face"].name == "cognitive-services-ns-diag"
    error_message = "Monitor Diagnostic name did not match expected"
  }

  # ComputerVision Cognitive Service
  assert {
    condition     = azurerm_cognitive_account.main["computerVision"].name == "ComputerVision-cog"
    error_message = "Cognitive account name did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["computerVision"].location == "westeurope"
    error_message = "Cognitive account location did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["computerVision"].resource_group_name == "cognitive-services-rg"
    error_message = "Cognitive account resource group did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["computerVision"].kind == "ComputerVision"
    error_message = "Cognitive account kind did not match expected"
  }

  assert {
    condition     = azurerm_cognitive_account.main["computerVision"].sku_name == "F0"
    error_message = "Cognitive account SKU did not match expected"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.cognitive-services["computerVision"].name == "cognitive-services-ns-diag"
    error_message = "Monitor Diagnostic name did not match expected"
  }

}