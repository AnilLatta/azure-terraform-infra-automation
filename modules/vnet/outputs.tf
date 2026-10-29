output "vnet_id" { value = azurerm_virtual_network.vnet.id }
output "vnet_name" { value = azurerm_virtual_network.vnet.name }
output "aks_subnet_id" { value = azurerm_subnet.aks_subnet.id }
output "app_subnet_id" { value = azurerm_subnet.app_subnet.id }
output "data_subnet_id" { value = azurerm_subnet.data_subnet.id }
