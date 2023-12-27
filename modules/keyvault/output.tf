output "id" {
  value = azurerm_key_vault.default.id
}

output "vault_uri" {
  value = azurerm_key_vault.default.vault_uri
}

output "app1_key_id" {
  value = azurerm_key_vault_key.app1.id
}

output "app2_key_id" {
  value = azurerm_key_vault_key.app2.id
}
