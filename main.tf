terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.84.0"
    }
  }
}

locals {
  workload = "st0r4g3"
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${local.workload}"
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "keyvault" {
  source              = "./modules/keyvault"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "storage" {
  source              = "./modules/storage"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  vnet_id                    = module.vnet.vnet_id
  subnet_id                  = module.vnet.subnet_id
  public_ip_address_to_allow = var.public_ip_address_to_allow

  keyvault_id          = module.keyvault.id
  keyvault_app1_key_id = module.keyvault.app1_key_id
  keyvault_app2_key_id = module.keyvault.app2_key_id
}

module "privatelink" {
  source              = "./modules/privatelink"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  vnet_id             = module.vnet.vnet_id
  subnet_id           = module.vnet.subnet_id
  resource_id         = module.storage.id
}
