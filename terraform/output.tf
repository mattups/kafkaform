output "resource_group_name" {
  value = azurerm_resource_group.rg_kafkaform.name
}

output "public_ip_address" {
  value = toset([
    for rg_kafkaform_instances in azurerm_linux_virtual_machine.rg_kafkaform_instances : rg_kafkaform_instances.public_ip_address
  ])
}

output "public_dns_name" {
  value = toset([
    for rg_kafkaform_public_ip in azurerm_public_ip.rg_kafkaform_public_ip : rg_kafkaform_public_ip.fqdn
  ])
}

output "tls_private_key" {
  value     = tls_private_key.rg_kafkaform_ssh_key.private_key_pem
  sensitive = true
}
