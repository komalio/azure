
module "virtualnetwork" {
  source              = "./modules/virtualnetwork"
  resource_group_name = data.azurerm_resource_group.test.name
  location            = var.location
  vnetname            = var.vnetname
}
data "azurerm_resource_group" "test" {
  name = var.resourcegroup
}