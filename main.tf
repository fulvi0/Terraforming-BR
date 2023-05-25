# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "rg_bonificacion_br_demo" "arq.banreservas.com" {
  name     = "rg_bonificacion_br_demo"
  location = "eastus2"
}

# Create a security group
resource "azurerm_network_security_group" "arq.banreservas.com" {
  name                = "my-security-group"
  location            = rg_bonificacion_br_demo.arq.banreservas.com.location
  resource_group_name = rg_bonificacion_br_demo.arq.banreservas.com.name
}

# Create an Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "arq.banreservas.com" {
  name                = "aks-cluster-bonificacion-demo"
  location            = rg_bonificacion_br_demo.arq.banreservas.com.location
  resource_group_name = rg_bonificacion_br_demo.arq.banreservas.com.name
  dns_prefix          = "aks-bf-br"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }
}

# Create an Azure Key Vault
resource "azurerm_key_vault" "arq.banreservas.com" {
  name                = "br-key-vault"
  location            = rg_bonificacion_br_demo.arq.banreservas.com.location
  resource_group_name = rg_bonificacion_br_demo.arq.banreservas.com.name
  sku_name            = "standard"
}

# Create two PostgreSQL instances
resource "azurerm_postgresql_server" "instance1" {
  name                = "psql-instance-bonificaciones"
  location            = rg_bonificacion_br_demo.arq.banreservas.com.location
  resource_group_name = rg_bonificacion_br_demo.arq.banreservas.com.name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  version             = "12"

  administrator_login          = "admin_user"
  administrator_login_password = "password123"
}

resource "azurerm_postgresql_server" "instance2" {
  name                = "psql-instance-nonemployee"
  location            = rg_bonificacion_br_demo.arq.banreservas.com.location
  resource_group_name = rg_bonificacion_br_demo.arq.banreservas.com.name
  sku_name            = "B_Gen5_2"
  storage_mb          = 10240
  version             = "13"

  administrator_login          = "admin_user"
  administrator_login_password = "password456"
}