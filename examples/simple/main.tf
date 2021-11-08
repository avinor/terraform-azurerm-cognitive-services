module "cognitive-services" {
  source = "../.."

  name                = "face"
  resource_group_name = "cognitive-services-rg"
  location            = "westeurope"

  sku_name = "F0"
  kind     = "Face"

  tags = {
    tag1 = "value1"
  }

}
