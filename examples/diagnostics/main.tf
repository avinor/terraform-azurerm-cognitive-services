module "cognitive-services" {
  source = "../.."

  name                = "cognitive-services"
  resource_group_name = "cognitive-services-rg"
  location            = "westeurope"

  cognitive_services_types = {
    face = {
      sku_name = "F0"
      kind     = "Face"
      custom_subdomain_name = "face-cog"
    }
    computerVision = {
      sku_name = "F0"
      kind     = "ComputerVision"
      custom_subdomain_name = "computer-vision-cog"
    }
  }


  network_acls = {
    default_action = "Deny"
    ip_rules = ["10.192.180.1","10.192.180.2"]
    virtual_network_rules = {
      subnet_id = "123"
      ignore_missing_vnet_service_endpoint = false
    }
  }

  tags = {
    tag1 = "value1"
  }

  diagnostics = {
    destination   = "test"
    eventhub_name = "diagnostics"
    logs          = ["all"]
    metrics       = ["all"]
  }

}
