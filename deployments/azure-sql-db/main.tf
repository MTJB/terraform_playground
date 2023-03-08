resource "azurerm_resource_group" "main" {
  name = "learn-tf-rg-${var.location}"
  location = var.location
}