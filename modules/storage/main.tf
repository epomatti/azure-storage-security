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

  # versioning
  # blob change feed
  # Enable version-level immutability support


  # Enable infrastructure encryption
  # CMK
  # infrastructure_encryption_enabled = 

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

resource "azurerm_storage_encryption_scope" "app1" {
  name               = "app1"
  storage_account_id = azurerm_storage_account.default.id
  source             = "Microsoft.Storage"

  key_vault_key_id = var.keyvault_app1_key_id

  infrastructure_encryption_required = true
}

resource "azurerm_storage_encryption_scope" "app2" {
  name               = "app2"
  storage_account_id = azurerm_storage_account.default.id
  source             = "Microsoft.Storage"

  key_vault_key_id = var.keyvault_app2_key_id

  infrastructure_encryption_required = true
}

# resource "azurerm_storage_container" "example" {
#   name                  = "vhds"
#   storage_account_name  = azurerm_storage_account.default.name
#   container_access_type = "private"  
# }
