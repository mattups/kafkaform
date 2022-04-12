# Create virtual network
resource "azurerm_virtual_network" "rg_kafkaform_network" {
  name                = "rg_kafkaform_network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_kafkaform.location
  resource_group_name = azurerm_resource_group.rg_kafkaform.name
}

# Create subnet
resource "azurerm_subnet" "rg_kafkaform_subnet" {
  name                 = "rg_kafkaform_subnet"
  resource_group_name  = azurerm_resource_group.rg_kafkaform.name
  virtual_network_name = azurerm_virtual_network.rg_kafkaform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "rg_kafkaform_public_ip" {
  for_each            = toset(var.kafka_instance_name)
  name                = "public_ip-${var.kafka_instance_prefix}-${each.key}"
  location            = azurerm_resource_group.rg_kafkaform.location
  resource_group_name = azurerm_resource_group.rg_kafkaform.name
  allocation_method   = "Dynamic"
}
