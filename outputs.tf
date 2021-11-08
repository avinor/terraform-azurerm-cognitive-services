output "id" {
  description = "The ID of the Cognitive Service account."
  value       = azurerm_cognitive_account.main.id
}

output "endpoint" {
  description = "The endpoint used to connect to Cognitive Service account."
  value       = azurerm_cognitive_account.main.endpoint
}
