output "database_name" {
  description = "Name of the PostgreSQL database instance"
  value       = azurerm_postgresql_database.db.name
}

output "postgresql_server_name" {
  description = "Name of the PostgreSQL server"
  value       = azurerm_postgresql_server.db.name
}
