# Resource Group (azurerm_resource_group)
A Resource Group (RG) is a logical container for grouping and managing the lifecycle, permissions, and billing of related Azure resources.

Key Behaviors:

Lifecycle Boundary: If you delete a resource group, Azure deletes every resource inside it.

Location Metadata: The location assigned to an RG (eastus, westeurope, etc.) stores the metadata of where resource management data resides—resources inside an RG can actually live in different regions than the RG itself.

RBAC & Locks: Access permissions (RBAC) and Management Locks applied at the Resource Group level are inherited by every child resource.

Azure CLI:

`az group create --name rg-demo --location eastus`  
`az group create -n rg-demo -l eastus`

Terraform:

```
resource "azurerm_resource_group" "rg" {
  name     = "rg-demo"
  location = "eastus"
}
```