variable "subscription_id" {
description = "existing subscription id"  
default = "5d289cb6-1606-4976-a203-3d3f947c9af6"
}
variable "client_id" {
description = "existing subscription client_id"  
default = "e0bf640b-4e5b-4287-92ba-28b77fd7861b"
}
variable "client_secret" {
description = "existing subscription client_secret"  
default = "FDngrt7cCwuYtBuHQ~uTLcs..x00bTXViW"
}
variable "tenant_id" {
description = "existing subscription tenant_id "  
default = "ba47b1c4-37b1-4301-b0d6-eca8ccf0818f"
}
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
  default     = "pra-ida-dev-vnet"
}

