variable "rg_region" {
  default = "westeurope"
}

variable "kafka_instance_prefix" {
  default = "kafka"
  type    = string
}

variable "kafka_instance_name" {
  type    = list(string)
  default = ["rest", "connect", "ksql", "schema", "control-center", "broker", "zookeeper"]
}

variable "kafka_instances_size" {
  default = "Standard_DC2s_v2"
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
