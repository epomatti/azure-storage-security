### User-Assigned Managed Identity ###
resource "azurerm_user_assigned_identity" "storage" {
  name                = "${var.workload}-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "keyvault_crypto_officer" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = azurerm_user_assigned_identity.storage.principal_id
}

### Storage ###
resource "random_string" "storage_name" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "default" {
  name                      = "st${var.workload}${random_string.storage_name.result}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  access_tier               = "Hot"

  # allow_nested_items_to_be_public = false
  # shared_access_key_enabled = true
  # default_to_oauth_authentication = 

  # point in time restore
  # soft delete blos
  # soft delete containers
  # soft delete files

  # blob change feed
  # Enable version-level immutability support

  blob_properties {
    # This disabled Legal Hold and version-level immutability
    versioning_enabled = var.blob_versioning_enabled
  }


  # Can only set on creation
  infrastructure_encryption_enabled = true

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.storage.id
    ]
  }

  customer_managed_key {
    key_vault_key_id          = var.keyvault_storage_key_id
    user_assigned_identity_id = azurerm_user_assigned_identity.storage.id
  }

  # Networking
  public_network_access_enabled = true

  # Internet / Microsoft routing
  network_rules {
    default_action             = "Deny"
    ip_rules                   = [var.public_ip_address_to_allow]
    virtual_network_subnet_ids = [var.subnet_id]
    bypass                     = ["AzureServices"]
  }
}


### Encryption Scopes ###
resource "azurerm_storage_encryption_scope" "app1" {
  name                               = "app1"
  storage_account_id                 = azurerm_storage_account.default.id
  source                             = "Microsoft.KeyVault"
  key_vault_key_id                   = var.keyvault_app1_key_id
  infrastructure_encryption_required = true
}

resource "azurerm_storage_encryption_scope" "app2" {
  name                               = "app2"
  storage_account_id                 = azurerm_storage_account.default.id
  source                             = "Microsoft.KeyVault"
  key_vault_key_id                   = var.keyvault_app2_key_id
  infrastructure_encryption_required = true
}

# Immutability policy




### Admin permissions ###
data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "data_contributor" {
  scope                = azurerm_storage_account.default.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
