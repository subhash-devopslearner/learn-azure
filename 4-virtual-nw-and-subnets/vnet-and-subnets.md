# 4. Virtual Network & Subnets (azurerm_virtual_network, azurerm_subnet)
A Virtual Network (VNet) is your private, isolated network boundary in Azure. Subnets segment that VNet into smaller CIDR blocks.

Key Behaviors:

Reserved IP Addresses: Azure reserves 5 IP addresses in every subnet (the network address, broadcast address, default gateway .1, and two Azure DNS mapping IPs .2 and .3). A /24 subnet yields 251 usable IPs, not 256.

Default Routing: Resources in different subnets within the same VNet can communicate with each other by default without additional configuration.

Delegation: Some PaaS services (e.g., App Service VNet Integration, Container Apps) require an entire subnet to be "delegated" solely to that service.

## Azure CLI:

```
# VNet and default Subnet
az network vnet create \
  --resource-group rg-demo \
  --name vnet-demo \
  --address-prefix 10.0.0.0/16 \
  --subnet-name snet-compute \
  --subnet-prefix 10.0.1.0/24
```

## Terraform
```
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-compute"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
```