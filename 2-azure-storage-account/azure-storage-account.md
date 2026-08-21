# Storage Account (azurerm_storage_account)
An Azure Storage Account is a top-level namespace that provides object (Blob), file share (Files), queue, and table storage.

Key Behaviors:

Global Uniqueness: The name must be globally unique across all of Azure, 3–24 characters long, and contain only lowercase letters and numbers (no hyphens or underscores).

Static Website Hosting: Enabling this creates a special, read-only system container named $web and provides a dedicated web endpoint URL (https://<account-name>.z13.web.core.windows.net).

Redundancy Options: Common tiers include LRS (Locally Redundant - 3 copies in one datacenter), ZRS (Zone Redundant - across 3 availability zones), and GRS (Geo-Redundant - replicated to a paired region).

Azure CLI:

```
az storage account create \
  --name mystoragedemo123 \
  --resource-group rg-demo \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2
```

Terraform:

```
resource "azurerm_storage_account" "storage" {
  name                     = "mystoragedemo123"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"  
}
```