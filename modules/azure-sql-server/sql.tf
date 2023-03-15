resource "random_password" "db_admin_password" {
  length           = 16
  special          = true
  override_special = "!#(-_=+[]?"
}

resource "azurerm_mssql_server" "sql_server" {
  location                     = var.location
  name                         = var.name
  resource_group_name          = var.resource_group
  version                      = var.sql-server-version
  administrator_login          = "CloudOpsAdmin"
  administrator_login_password = random_password.db_admin_password.result
  tags                         = var.tags
}

resource "azurerm_mssql_firewall_rule" "az_firewall" {
  name             = "Allow access to Azure services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "extra_firewalls" {
  count            = length(var.firewalls)
  name             = var.firewalls[count.index].name
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.firewalls[count.index].start_ip_address
  end_ip_address   = var.firewalls[count.index].end_ip_address
}

resource "azurerm_mssql_database" "database" {
  server_id          = azurerm_mssql_server.sql_server.id
  name               = var.name
  collation          = var.db_collation
  sku_name           = var.db_sku
  read_replica_count = var.num_read_replicas
  tags               = var.tags
}

resource "random_password" "db_user_passwords" {
  count            = length(var.db_users)
  length           = 16
  special          = true
  override_special = "!#(-_=+[]?"
}

resource "mssql_user" "example" {

  count = length(var.db_users)

  server {
    host = azurerm_mssql_server.sql_server.fully_qualified_domain_name
    login {
      username = azurerm_mssql_server.sql_server.administrator_login
      password = azurerm_mssql_server.sql_server.administrator_login_password
    }
  }

  database = azurerm_mssql_database.database.name
  username = var.db_users[count.index].name
  password = random_password.db_user_passwords[count.index].result
  roles    = var.db_users[count.index].roles
}