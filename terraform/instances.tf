# Create SSH key
resource "tls_private_key" "rg_kafkaform_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create network interfaces
resource "azurerm_network_interface" "rg_kafkaform_nic" {
  for_each            = toset(var.kafka_instance_name)
  name                = "nic-${var.kafka_instance_prefix}-${each.key}"
  location            = azurerm_resource_group.rg_kafkaform.location
  resource_group_name = azurerm_resource_group.rg_kafkaform.name

  ip_configuration {
    name                          = "nic_config-${var.kafka_instance_prefix}-${each.key}"
    subnet_id                     = azurerm_subnet.rg_kafkaform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.rg_kafkaform_public_ip[each.key].id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "kafkaform_sg" {
  for_each                  = toset(var.kafka_instance_name)
  network_interface_id      = azurerm_network_interface.rg_kafkaform_nic[each.key].id
  network_security_group_id = azurerm_network_security_group.kafkaform_nsg.id
}


# Create instances
resource "azurerm_linux_virtual_machine" "rg_kafkaform_instances" {
  for_each              = toset(var.kafka_instance_name)
  name                  = "${var.kafka_instance_prefix}-${each.key}"
  location              = azurerm_resource_group.rg_kafkaform.location
  resource_group_name   = azurerm_resource_group.rg_kafkaform.name
  network_interface_ids = [azurerm_network_interface.rg_kafkaform_nic[each.key].id]
  size                  = var.kafka_instances_size

  os_disk {
    name                 = "${var.kafka_instance_prefix}-${each.key}-os_disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = "latest"
  }

  computer_name                   = "${var.kafka_instance_prefix}-${each.key}"
  admin_username                  = var.kafka_admin_user
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.kafka_admin_user
    public_key = tls_private_key.rg_kafkaform_ssh_key.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.rg_kafkaform_storage_account.primary_blob_endpoint
  }
}
