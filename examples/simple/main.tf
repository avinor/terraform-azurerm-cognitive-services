module "cognitive-services" {
  source = "../.."

  name                = "cognitive-services"
  resource_group_name = "cognitive-services-rg"
  location            = "westeurope"

  cognitive_services_types = {
    face = {
      sku_name = "F0"
      kind     = "Face"
    }
    computerVision = {
      sku_name = "F0"
      kind     = "ComputerVision"
    }
  }

  tags = {
    tag1 = "value1"
  }

}
