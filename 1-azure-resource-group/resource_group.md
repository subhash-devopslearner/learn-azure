# Resource Group (azurerm_resource_group)
A Resource Group (RG) is a logical container for grouping and managing the lifecycle, permissions, and billing of related Azure resources.

Key Behaviors:

Lifecycle Boundary: If you delete a resource group, Azure deletes every resource inside it.

Location Metadata: The location assigned to an RG (eastus, westeurope, etc.) stores the metadata of where resource management data resides—resources inside an RG can actually live in different regions than the RG itself.

RBAC & Locks: Access permissions (RBAC) and Management Locks applied at the Resource Group level are inherited by every child resource.

Azure CLI:

`az group create --name rg-demo --location eastus`  
`az group create -n rg-demo -l eastus`

```
az group --help

Group
    az group : Manage resource groups and template deployments.

Subgroups:
    lock   : Manage Azure resource group locks.

Commands:
    create : Create a new resource group.
    delete : Delete a resource group.
    exists : Check if a resource group exists.
    export : Captures a resource group as a template.
    list   : List resource groups.
    show   : Gets a resource group.
    update : Update a resource group.
    wait   : Place the CLI in a waiting state until a condition of the resource group is met.
```

Terraform:

```
resource "azurerm_resource_group" "rg" {
  name     = "rg-demo"
  location = "eastus"
}
```