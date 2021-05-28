resource "azurerm_virtual_network" "virtualnetwork" {
  name                = var.vnetname
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name 
}

resource "azurerm_subnet" "subnet" {
  name                 = "idasubnet"
  resource_group_name  = var.resource_group_name 
  virtual_network_name = azurerm_virtual_network.virtualnetwork.name
  address_prefixes       = ["10.0.1.0/24"]

  enforce_private_link_endpoint_network_policies = true
}