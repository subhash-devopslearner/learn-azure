resource "azurerm_resource_group" "test_rg" {
  name     = "test-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet_demo" {
  name                = "vnet-demo"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  address_space       = ["10.0.0.0/16"]    
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-compute"  
  resource_group_name  = azurerm_resource_group.test_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_demo.name
  address_prefixes     = ["10.0.1.0/24"]    
}
