# calling existing key vault details
data "azurerm_key_vault" "main" {
  name                = "sanofi-keyvault"
  resource_group_name = "sanofi-dev-rg"
}

# calling existing key vault secret
data "azurerm_key_vault_secret" "admin_username" {
  name         = "vm-admin-username"
  key_vault_id = data.azurerm_key_vault.main.id
}

# calling existing key vault secret details
data "azurerm_key_vault_secret" "admin_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.main.id
}
