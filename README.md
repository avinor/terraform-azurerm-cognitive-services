# terraform-azurerm-cognitive-services

A terraform module for Azure Cognitive Services such as Face API and Computer Vision

## Usage

Example that shows configuration for deployment of cogtnitive service Face API 

```terraform
module "cognitive-services" {
  source = "github.com/avinor/terraform-azurerm-cognitive-services"

  name                = "cognitive-services-face"
  resource_group_name = "cognitive-services-rg"
  location            = "westeurope"

  sku_name = "F0"
  kind     = "Face"

  tags = {
    tag1 = "value1"
  }
}
```

## Supported Cognitive Services

Set "kind" variable which represents type of Cognitive Service Account that should be created. Possible values are:

* Academic
* AnomalyDetector
* Bing.Autosuggest
* Bing.Autosuggest.v7
* Bing.CustomSearch
* Bing.Search
* Bing.Search.v7
* Bing.Speech
* Bing.SpellCheck
* Bing.SpellCheck.v7
* CognitiveServices
* ComputerVision
* ContentModerator
* CustomSpeech
* CustomVision.Prediction
* CustomVision.Training
* Emotion
* Face
* FormRecognizer
* ImmersiveReader
* LUIS
* LUIS.Authoring
* MetricsAdvisor
* Personalizer
* QnAMaker
* Recommendations
* SpeakerRecognition
* Speech
* SpeechServices
* SpeechTranslation
* TextAnalytics
* TextTranslation
* WebLM

Warning! Changing this forces a new resource to be created.

## SKU Name

SKU Name for this Cognitive Service Account. Possible values are F0, F1, S, S0, S1, S2, S3, S4, S5, S6, P0, P1, and P2

## Diagnostics

Diagnostics settings can be sent to either storage account, event hub or Log Analytics workspace. The variable `diagnostics.destination` is the id of receiver, ie. storage account id, event namespace authorization rule id or log analytics resource id. Depending on what id is it will detect where to send. Unless using event namespace the `eventhub_name` is not required, just set to `null` for storage account and log analytics workspace.

Setting `all` in logs and metrics will send all possible diagnostics to destination. If not using `all` type name of categories to send.
