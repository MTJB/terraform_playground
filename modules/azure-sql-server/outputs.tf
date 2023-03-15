output "db_admin_name" {
  value = azurerm_mssql_server.sql_server.administrator_login
}

output "db_admin_password" {
  value = azurerm_mssql_server.sql_server.administrator_login_password
}

output "db_host" {
  value = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "db_name" {
  value = azurerm_mssql_database.database.name
}