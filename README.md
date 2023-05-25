Certainly! Here's an example Terraform code that creates the infrastructure you described in Azure:

```hcl
# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "my-resource-group"
  location = "East US"
}

# Create a security group
resource "azurerm_network_security_group" "example" {
  name                = "my-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create an Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
}

# Create an Azure Key Vault
resource "azurerm_key_vault" "example" {
  name                = "my-key-vault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "standard"
}

# Create two PostgreSQL instances
resource "azurerm_postgresql_server" "instance1" {
  name                = "my-postgres-instance-1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  version             = "12"

  administrator_login          = "admin_user"
  administrator_login_password = "password123"
}

resource "azurerm_postgresql_server" "instance2" {
  name                = "my-postgres-instance-2"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B_Gen5_2"
  storage_mb          = 10240
  version             = "13"

  administrator_login          = "admin_user"
  administrator_login_password = "password456"
}
```

Make sure to customize the values such as resource group name, location, security group name, AKS cluster name, key vault name, and PostgreSQL instance names, as well as other configurations according to your requirements. Also, ensure you have the Azure provider correctly configured before running this Terraform code.

This code creates a resource group, a security group, an Azure Kubernetes Service (AKS) cluster, an Azure Key Vault, and two PostgreSQL instances in Azure.