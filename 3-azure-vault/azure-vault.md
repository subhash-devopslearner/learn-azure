# Azure Key Vault (azurerm_key_vault & azurerm_key_vault_secret)
Azure Key Vault is a centralized, hardware-security-backed service for storing API keys, passwords, certificates, and encryption keys.

Key Behaviors:

Global Uniqueness: Vault names must be globally unique across Azure (3–24 alphanumeric characters, hyphens allowed).

Access Models: Key Vault supports two permission models:

Azure RBAC (Recommended): Uses built-in roles like Key Vault Secrets User or Key Vault Administrator.

Vault Access Policies: Legacy JSON-based policies bound directly to object IDs.

Soft Delete & Purge Protection: By default, deleted vaults and secrets enter a soft-deleted retention state (typically 7–90 days) unless explicitly purged.

Azure CLI:

## Create Vault
```
az keyvault create \
  --name kv-demo-12345 \
  --resource-group rg-demo \
  --location eastus \
  --enable-rbac-authorization true

# Add Secret
az keyvault secret set \
  --vault-name kv-demo-12345 \
  --name "AppSecret" \
  --value "SuperSecretPassword!"
```

Terraform:

```
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                      = "kv-demo-12345"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "AppSecret"
  value        = "SuperSecretPassword!"
  key_vault_id = azurerm_key_vault.kv.id
}
```

## Commands to manage Azure vault secrets using Python code
```
python3 -m venv venv
source venv/bin/activate
python3 -m pip install --upgrade pip
pip install azure-identity
pip install azure-keyvault-secrets

az group create --name "test-rg2" --location "EastUS"
az keyvault create --name "subhash2028kv" --resource-group "test-rg2" --enable-rbac-authorization true --enable-purge-protection true

export KEY_VAULT_NAME=subhash2028kv

az ad signed-in-user show --query id --output tsv 
az account show

az role assignment create --role "Key Vault Secrets Officer" \
--assignee $(az ad signed-in-user show --query id --output tsv) \
--scope "/subscriptions/--------/resourceGroups/test-rg2/providers/Microsoft.KeyVault/vaults/subhash2028kv"

python kv_secrets.py 
``` 