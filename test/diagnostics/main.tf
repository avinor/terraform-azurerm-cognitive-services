module "cognitive-services" {
  source = "../../"

  name                = "cognitive-services-face"
  resource_group_name = "cognitive-services-rg"
  location            = "westeurope"

  sku_name = "F0"
  kind     = "Face"

  tags = {
    tag1 = "value1"
  }

  diagnostics = {
    destination   = "test"
    eventhub_name = "diagnostics",
    logs          = ["all"],
    metrics       = ["all"],
  }

}
