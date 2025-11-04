variable "project" {
  description = "Google Cloud project ID"
  type        = string
  default     = "skillbox-devops-basic"
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-west4"
}

variable "zone" {
  description = "Google Cloud zone"
  type        = string
  default     = "us-west4-c"
}

variable "network_name" {
  description = "Имя сети"
  type        = string
  default     = "app-network"
}

variable "subnet_name" {
  description = "Имя подсети"
  type        = string
  default     = "app-subnet"
}

