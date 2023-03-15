resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
}

module "sql_db" {
  source = "../../modules/azure-sql-server"

  firewalls      = var.firewalls
  db_users       = var.db_users
  location       = azurerm_resource_group.rg.location
  name           = "sql-server"
  resource_group = azurerm_resource_group.rg.name
  tags = {
    "Environment" : var.environment
    "Product" : "MTJB"
  }
}

# TODO vault
# TODO terraform fmt
# TODO README