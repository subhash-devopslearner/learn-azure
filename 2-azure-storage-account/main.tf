terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
    name        = "test-rg"
    location    = "east us"       
}

resource "azurerm_storage_account" "storage" {
  name                     = "subhash2026"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"  
}

resource "azurerm_storage_container" "container" {
  name                     = "my2026files"
  storage_account_id       = azurerm_storage_account.storage.id
  container_access_type    = "private"
}

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "config" {
}

resource "azurerm_role_assignment" "blobuploadrole" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.config.object_id
}

resource "azurerm_storage_blob" "blobupload" {
  name                 = "firstFileUpload.txt"
  storage_container_id = azurerm_storage_container.container.id
  type                 = "Block"
  source               = "firstFileUpload.txt"
}

data "azurerm_storage_account_blob_container_sas" "sas-share" {
  connection_string = azurerm_storage_account.storage.primary_connection_string
  container_name    = azurerm_storage_container.container.name
  https_only        = true

  start  = "2026-08-25T00:00:00Z"
  expiry = "2026-08-26T00:00:00Z"

  permissions {
    read   = true
    write  = false
    delete = false
    list   = true
    add    = false
    create = false
  }
}

# Use terraform output secure_blob_url to see shared url
output "secure_blob_url" {
  value     = "${azurerm_storage_blob.blobupload.url}${data.azurerm_storage_account_blob_container_sas.sas-share.sas}"
  sensitive = true
}