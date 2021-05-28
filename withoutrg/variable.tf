variable "resourcegroup" {
description = "name of the resource group "
default = "rg-pra-ida-test3-eastus-01"
}
variable "location" {
description = "where the resources will create"
default = "East us"
}
variable "vnetname" {
  description = "virtual network name for private endpoint connections"
  default     = "pra-ida-dev-vnet1"
}

