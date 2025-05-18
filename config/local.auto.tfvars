# Project
subscription_id = "00000000-0000-0000-0000-000000000000"
location        = "eastus2"

# Storage
public_ip_address_to_allow = "100.100.100.100/30"
blob_versioning_enabled    = true

# Customer-managed key (CMK) is always allowed for Blob and Files.
# It can be enabled for Queue and Table services as wells. ⚠️ Cannot be changed later 
queue_encryption_key_type = "Account"
table_encryption_key_type = "Account"
