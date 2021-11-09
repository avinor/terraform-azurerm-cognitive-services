output "id" {
  description = "The ID of the Cognitive Service account."
  value       = { for k, v in azurerm_cognitive_account.main : k => v.id }
}

output "endpoint" {
  description = "The endpoint used to connect to Cognitive Service account."
  value       = { for k, v in azurerm_cognitive_account.main : k => v.endpoint }
}
