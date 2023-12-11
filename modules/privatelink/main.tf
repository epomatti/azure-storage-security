locals {
  name = "storage"
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}


resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "blob-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = true
}

resource "azurerm_private_endpoint" "default" {
  name                = "pe-blob"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name = azurerm_private_dns_zone.blob.name
    private_dns_zone_ids = [
      azurerm_private_dns_zone.blob.id
    ]
  }

  private_service_connection {
    name                           = "storage"
    private_connection_resource_id = var.resource_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}
