# Create SSH key
resource "tls_private_key" "rg_kafkaform_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create instances
resource "azurerm_linux_virtual_machine" "rg_kafkaform_instances" {
  count                 = var.kafka_instances_count
  name                  = "${var.kafka_instances_prefix}-${count.index}"
  location              = azurerm_resource_group.rg_kafkaform.location
  resource_group_name   = azurerm_resource_group.rg_kafkaform.name
  network_interface_ids = [azurerm_network_interface.rg_kafkaform_nic.id]
  size                  = var.kafka_instances_size

  os_disk {
    name                 = "${var.kafka_instances_prefix}-${count.index}-os_disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = "latest"
  }

  computer_name                   = "${var.kafka_instances_prefix}-${count.index}"
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