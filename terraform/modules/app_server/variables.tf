variable "environment" {
  description = "Environment name (staging, prod)"
  type        = string
}

variable "gcp_zone" {}
variable "machine_type" {}
variable "boot_image" {}
variable "ssh_user" {}
variable "ssh_public_key_path" {}
variable "network_id" {}
variable "subnet_id" {}

