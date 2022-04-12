# Generate random text for a unique storage account name
resource "random_id" "rg_kafkaform_random_id" {
  keepers = {
    resource_group = azurerm_resource_group.rg_kafkaform.name
  }
  byte_length = 8
}

# Create storage account 
resource "azurerm_storage_account" "rg_kafkaform_storage_account" {
  name                     = "diag${random_id.rg_kafkaform_random_id.hex}"
  location                 = azurerm_resource_group.rg_kafkaform.location
  resource_group_name      = azurerm_resource_group.rg_kafkaform.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
