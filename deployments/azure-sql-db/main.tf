resource "azurerm_resource_group" "main" {
  name     = "learn-tf-rg-${var.location}"
  location = var.location
}

resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#(-_=+[]?"
}

resource "azurerm_mssql_server" "sql-server" {
  location                     = azurerm_resource_group.main.location
  name                         = "learn-tf-mssql-${azurerm_resource_group.main.location}"
  resource_group_name          = azurerm_resource_group.main.name
  version                      = "12.0"
  administrator_login          = var.sql-server-admin-username
  administrator_login_password = random_password.sql_admin_password.result
}

resource "azurerm_mssql_database" "database" {
  server_id                      = azurerm_mssql_server.sql-server.id
  name                           = "learn-tf-mssql-db-${var.location}"
  collation                      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name                       = "GP_Gen5_2"
  storage_account_type           = "Local"
  read_replica_count             = 0
}

resource "random_password" "database_sa_password" {
  length           = 16
  special          = true
  override_special = "!#(-_=+[]?"
}

resource "mssql_user" "example" {
  server {
    host = azurerm_mssql_server.sql-server.fully_qualified_domain_name
    login {
      username = var.sql-server-admin-username
      password = random_password.sql_admin_password.result
    }
  }
  username = "mark_the_sa"
  roles    = [ "db_owner" ]
}