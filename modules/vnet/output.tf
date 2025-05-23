output "vnet_id" {
  value = azurerm_virtual_network.default.id
}

output "subnet_id" {
  value = azurerm_subnet.default.id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private_endpoints.id
}
