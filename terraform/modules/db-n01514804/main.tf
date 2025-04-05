resource "azurerm_postgresql_server" "db" {
  name                = "n14804-db"
  location            = var.location
  resource_group_name = var.resource_group
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  administrator_login          = "adminuser"
  administrator_login_password = "SecurePassword123"
  version                     = "11"
  backup_retention_days   = 7
  geo_redundant_backup_enabled = false

  ssl_enforcement_enabled = true  
}
