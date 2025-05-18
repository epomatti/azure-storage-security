data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "default" {
  name                = "kv-${var.workload}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Required for CMK operations
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "current" {
  scope                = azurerm_key_vault.default.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_key" "storage" {
  name         = "cmk-storage"
  key_vault_id = azurerm_key_vault.default.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    notify_before_expiry = "P29D"
    expire_after         = "P90D"
  }

  depends_on = [azurerm_role_assignment.current]
}

resource "azurerm_key_vault_key" "app1" {
  name         = "app1-key"
  key_vault_id = azurerm_key_vault.default.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    notify_before_expiry = "P29D"
    expire_after         = "P90D"
  }

  depends_on = [azurerm_role_assignment.current]
}

resource "azurerm_key_vault_key" "app2" {
  name         = "app2-key"
  key_vault_id = azurerm_key_vault.default.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }
    notify_before_expiry = "P29D"
    expire_after         = "P90D"
  }

  depends_on = [azurerm_role_assignment.current]
}
