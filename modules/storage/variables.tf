variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "workload" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "public_ip_address_to_allow" {
  type = string
}

variable "keyvault_id" {
  type = string
}

variable "keyvault_storage_key_id" {
  type = string
}

variable "keyvault_app1_key_id" {
  type = string
}

variable "keyvault_app2_key_id" {
  type = string
}
