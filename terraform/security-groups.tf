# Create Network Security Group and rule
resource "azurerm_network_security_group" "kafkaform_nsg" {
  name                = "kafka-nsg"
  location            = azurerm_resource_group.rg_kafkaform.location
  resource_group_name = azurerm_resource_group.rg_kafkaform.name
}

# Kafka NSG rules
# SSH
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Kafka Brokers
resource "azurerm_network_security_rule" "allow_kafka_broker" {
  name                        = "kafka-broker"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "9092"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Kafka Connect REST API
resource "azurerm_network_security_rule" "allow_kafka_connect" {
  name                        = "kafka-connect-api"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8083"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# KSQL REST API
resource "azurerm_network_security_rule" "allow_ksql_api" {
  name                        = "ksql-api"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8088"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Kafka REST Prozy
resource "azurerm_network_security_rule" "allow_kafka_rest_proxy" {
  name                        = "kafka-rest-proxy"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8082"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Kafka Schema Registry REST API
resource "azurerm_network_security_rule" "allow_kafka_schema_registry" {
  name                        = "kafka-schema-registry"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8081"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# JMX
resource "azurerm_network_security_rule" "allow_kafka_jmx" {
  name                        = "kafka-jmx"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1099"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Zookeeper peerport
resource "azurerm_network_security_rule" "allow_zookeeper_peerport" {
  name                        = "zookeeper-peerport"
  priority                    = 107
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2888"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Zookeeper leaderport
resource "azurerm_network_security_rule" "allow_zookeeper_leaderport" {
  name                        = "zookeeper-leaderport"
  priority                    = 108
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3888"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Zookeeper clientport
resource "azurerm_network_security_rule" "allow_zookeeper_clientport" {
  name                        = "zookeeper-clientport"
  priority                    = 109
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2181"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}

# Control center
resource "azurerm_network_security_rule" "allow_control_center" {
  name                        = "control-center"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "9021"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg_kafkaform.name
  network_security_group_name = azurerm_network_security_group.kafkaform_nsg.name
}


# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "kafkaform_sg" {
  network_interface_id      = azurerm_network_interface.rg_kafkaform_nic.id
  network_security_group_id = azurerm_network_security_group.kafkaform_nsg.id
}

