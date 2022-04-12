variable "rg_region" {
  default = "westeurope"
}

variable "kafka_instances_prefix" {
  default = "kafka-broker"
  type    = string
}

variable "kafka_instances_count" {
  default = 1
  type    = number
}

variable "kafka_instances_size" {
  default = "Standard_D2ads_v5"
}

variable "kafka_admin_user" {
  default = "kafka-admin"
}

variable "source_image_offer" {
  default = "0001-com-ubuntu-server-focal"
}

variable "source_image_sku" {
  default = "20_04-lts-gen2"
}

variable "source_image_publisher" {
  default = "Canonical"
}