variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-west4"
}

variable "gcp_zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-west4-c"
}

variable "machine_type" {
  description = "Machine type for compute instance"
  type        = string
  default     = "e2-micro"
}

variable "boot_image" {
  description = "Boot disk image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "subdomain" {
  description = "Subdomain name for the application (e.g., 'app' for app.avtostrada.kz)"
  type        = string
  default     = "skillbox"
}

variable "root_domain" {
  description = "Root domain name (e.g., 'avtostrada.kz')"
  type        = string
  default     = "avtostrada.kz"
}

