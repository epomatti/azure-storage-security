variable "subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "public_ip_address_to_allow" {
  type = string
}

variable "blob_versioning_enabled" {
  type = bool
}

variable "queue_encryption_key_type" {
  type = string
}

variable "table_encryption_key_type" {
  type = string
}
