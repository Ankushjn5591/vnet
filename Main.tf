provider "azurerm" {
  features{}
}

data "azurerm_resource_group" "rg1" {
  name                = "ankushrg"
}

data "azurerm_resource_group" "rg2" {
  name                = "chhavirg"
}
data "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name = data.azurerm_resource_group.rg1.name
}

data "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  resource_group_name = data.azurerm_resource_group.rg2.name
}

resource "azurerm_virtual_network_peering" "vnet1_vnet2" {
  name                          = "vnet1-vnet2"
  resource_group_name           = data.azurerm_resource_group.rg1.name
  virtual_network_name          = data.azurerm_virtual_network.vnet1.name
  remote_virtual_network_id     = data.azurerm_virtual_network.vnet2.id
  allow_virtual_network_access  = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
}

resource "azurerm_virtual_network_peering" "vnet2_vnet1" {
  name                          = "vnet2-vnet1"
  resource_group_name           = data.azurerm_resource_group.rg2.name
  virtual_network_name          = data.azurerm_virtual_network.vnet2.name
  remote_virtual_network_id     = data.azurerm_virtual_network.vnet1.id
  allow_virtual_network_access  = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
}

terraform {
  backend "azurerm" {
    resource_group_name  = "Storagerg"
    storage_account_name = "storageaccount5591"
    container_name       = "tfstate"
    key                  = "vnetpeering.terraform.tfstate"
    access_key = "9DcT8nW/iKr0v2t8bfFIfM24sfJRGva1oD4macMbw6UkSwUXYHJr0ErQzgv15oErzQebT6lpi4zl+ASt2Lfeeg=="
  }
}