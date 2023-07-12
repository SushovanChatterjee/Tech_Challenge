resource "azurerm_resource_group" "rg-01" {
  name     = var.rg_name
  location = var.location
}
resource "azurerm_storage_account" "sa-01" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_recovery_services_vault" "rsv-01" {
  name                = var.rsv_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  soft_delete_enabled = true
}