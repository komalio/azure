output "vnetid" {
  value = azurerm_virtual_network.virtualnetwork.id
}
output "subnetid" {
  value = azurerm_subnet.subnet.id
}