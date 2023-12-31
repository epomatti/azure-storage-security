variable "location" {
  type    = string
  default = "eastus2"
}

variable "public_ip_address_to_allow" {
  type = string
}

variable "blob_versioning_enabled" {
  type = bool
}
