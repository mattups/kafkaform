# Create resource group.
resource "azurerm_resource_group" "rg_kafkaform" {
  name     = "rg-kafkaform"
  location = var.rg_region
}
