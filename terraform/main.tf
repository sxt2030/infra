terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# VPC Network
resource "google_compute_network" "app_network" {
  name                    = "app-network"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "app_subnet" {
  name          = "app-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.app_network.id
}

# Firewall Rules
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.app_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = google_compute_network.app_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.app_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-server"]
}

resource "google_compute_firewall" "allow_health_check" {
  name    = "allow-health-check"
  network = google_compute_network.app_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = ["http-server"]
}


module "app_server_staging" {
  source              = "./modules/app_server"
  environment         = "staging"
  gcp_zone            = var.gcp_zone
  machine_type        = var.machine_type
  boot_image          = var.boot_image
  ssh_user            = var.ssh_user
  ssh_public_key_path = var.ssh_public_key_path
  network_id          = google_compute_network.app_network.id
  subnet_id           = google_compute_subnetwork.app_subnet.id
}

module "app_server_prod" {
  source              = "./modules/app_server"
  environment         = "prod"
  gcp_zone            = var.gcp_zone
  machine_type        = var.machine_type
  boot_image          = var.boot_image
  ssh_user            = var.ssh_user
  ssh_public_key_path = var.ssh_public_key_path
  network_id          = google_compute_network.app_network.id
  subnet_id           = google_compute_subnetwork.app_subnet.id
}



# Compute Instance
#resource "google_compute_instance" "app_server" {
#  name         = "app-server"
#  machine_type = var.machine_type
#  zone         = var.gcp_zone
#
#  tags = ["http-server", "https-server", "ssh-server"]
#
#  boot_disk {
#    initialize_params {
#      image = var.boot_image
#      size  = 20
#      type  = "pd-standard"
#    }
#  }
#
#  network_interface {
#    network    = google_compute_network.app_network.id
#    subnetwork = google_compute_subnetwork.app_subnet.id
#
#    access_config {
#      // Ephemeral public IP
#    }
#  }
#
#  metadata = {
#    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
#  }
#
#  metadata_startup_script = <<-EOF
#    #!/bin/bash
#    apt-get update
#  EOF
#
#  service_account {
#    scopes = ["cloud-platform"]
#  }
#}

# Instance Group
#resource "google_compute_instance_group" "app_instance_group" {
#  name = "app-instance-group"
#  zone = var.gcp_zone
#
#  instances = [
#    google_compute_instance.app_server.id
#  ]
#
#  named_port {
#    name = "http"
#    port = 80
#  }
#}

# Health Check
#resource "google_compute_health_check" "app_health_check" {
#  name                = "app-health-check"
#  check_interval_sec  = 5
#  timeout_sec         = 5
#  healthy_threshold   = 2
#  unhealthy_threshold = 2
#
#  http_health_check {
#    port         = 80
#    request_path = "/health"
#  }
#}

# Backend Service
#resource "google_compute_backend_service" "app_backend" {
#  name          = "app-backend-service"
#  protocol      = "HTTP"
#  timeout_sec   = 10
#  health_checks = [google_compute_health_check.app_health_check.id]
#
#  backend {
#    group           = google_compute_instance_group.app_instance_group.id
#    balancing_mode  = "UTILIZATION"
#    capacity_scaler = 1.0
#  }
#}

# URL Map
#resource "google_compute_url_map" "app_url_map" {
#  name            = "app-url-map"
#  default_service = google_compute_backend_service.app_backend.id
#}

# HTTP Proxy
#resource "google_compute_target_http_proxy" "app_http_proxy" {
#  name    = "app-http-proxy"
#  url_map = google_compute_url_map.app_url_map.id
#}

#resource "google_compute_global_address" "app_lb_ip" {
#  name = "app-lb-ip"
#}


# Global Forwarding Rule (Load Balancer)
#resource "google_compute_global_forwarding_rule" "app_forwarding_rule" {
#  name                  = "app-forwarding-rule"
#  target                = google_compute_target_http_proxy.app_http_proxy.id
#  port_range            = "80"
#  ip_protocol           = "TCP"
#  load_balancing_scheme = "EXTERNAL"
#  ip_address            = google_compute_global_address.app_lb_ip.id
#}

# DNS Zone (Cloud DNS) - используется только если управляем всей зоной
# Для поддомена основного домена это не нужно, закомментировано
# resource "google_dns_managed_zone" "app_dns_zone" {
#   name        = "app-dns-zone"
#   dns_name    = "${var.root_domain}."
#   description = "DNS zone for application"
# }

# Если используем поддомен существующего домена, DNS записи создаём вручную
# или используем существующую зону в Cloud DNS (если домен уже там)

# Internet Gateway
resource "google_compute_router" "app_router" {
  name    = "app-router"
  network = google_compute_network.app_network.id
  region  = var.gcp_region
}

resource "google_compute_router_nat" "app_nat" {
  name                               = "app-nat"
  router                             = google_compute_router.app_router.name
  region                             = var.gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_instance" "gitlab-server" {
  name         = "gitlab-server"
  machine_type = "e2-standard-2"
  zone         = "us-west4-c"

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20251023"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = "app-network"
    subnetwork = "app-subnet"
    access_config {
      nat_ip = "34.50.169.169"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC... maxpack2030@gmail.com"
  }

  tags = ["http-server", "https-server", "ssh-server"]
}


# === Backend Services ===
resource "google_compute_backend_service" "backend_staging" {
  name          = "backend-staging"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [module.app_server_staging.health_check_id]

  backend {
    group           = module.app_server_staging.instance_group_id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_backend_service" "backend_prod" {
  name          = "backend-prod"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [module.app_server_prod.health_check_id]

  backend {
    group           = module.app_server_prod.instance_group_id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# === URL Map with Path or Host Rules ===
resource "google_compute_url_map" "app_url_map" {
  name = "app-url-map"

  host_rule {
    hosts        = ["staging.avtostrada.kz"]
    path_matcher = "staging-matcher"
  }

  host_rule {
    hosts        = ["skillbox.avtostrada.kz"]
    path_matcher = "prod-matcher"
  }

  # NEW: fallback for IP or unknown hosts
  host_rule {
    hosts        = ["*"]
    path_matcher = "staging-matcher"
  }

  path_matcher {
    name            = "staging-matcher"
    default_service = google_compute_backend_service.backend_staging.id
  }

  path_matcher {
    name            = "prod-matcher"
    default_service = google_compute_backend_service.backend_prod.id
  }

  default_service = google_compute_backend_service.backend_prod.id
}


# === HTTP Proxy + Forwarding Rule ===
resource "google_compute_target_http_proxy" "app_http_proxy" {
  name    = "app-http-proxy"
  url_map = google_compute_url_map.app_url_map.id
}

resource "google_compute_global_address" "app_lb_ip" {
  name = "app-lb-ip"
}

resource "google_compute_global_forwarding_rule" "app_forwarding_rule" {
  name                  = "app-forwarding-rule"
  target                = google_compute_target_http_proxy.app_http_proxy.id
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.app_lb_ip.id
}


# =========================================================
# Monitoring Infrastructure (Prometheus + Grafana)
# =========================================================

# Firewall for monitoring traffic
resource "google_compute_firewall" "allow_monitoring_traffic" {
  name    = "allow-monitoring-traffic"
  network = google_compute_network.app_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "3000", "9090", "9100"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["monitoring", "grafana"]
}

# === Prometheus VM ===
resource "google_compute_instance" "prometheus_vm" {
  name         = "prometheus-vm"
  machine_type = "e2-micro"
  zone         = var.gcp_zone

  tags = ["monitoring", "ssh-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20251023"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = google_compute_network.app_network.id
    subnetwork = google_compute_subnetwork.app_subnet.id
    access_config {} # ephemeral public IP
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

# === Grafana VM ===
resource "google_compute_instance" "grafana_vm" {
  name         = "grafana-vm"
  machine_type = "e2-small"
  zone         = var.gcp_zone

  allow_stopping_for_update = true
  tags                      = ["grafana", "ssh-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20251023"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = google_compute_network.app_network.id
    subnetwork = google_compute_subnetwork.app_subnet.id
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "internal_monitoring" {
  name    = "allow-internal-monitoring"
  network = google_compute_network.app_network.id

  direction = "INGRESS"
  priority  = 1000

  # Разрешаем трафик только из внутренней подсети
  source_ranges = ["10.0.1.0/24"]

  # Порты для Node Exporter и Go App
  allow {
    protocol = "tcp"
    ports    = ["9100", "8080"]
  }

  description = "Allow internal monitoring ports for Node Exporter and Go App"
}

# Firewall rule: allow internal access to Loki
resource "google_compute_firewall" "allow_loki_internal" {
  name    = "allow-loki-internal"
  network = google_compute_network.app_network.name

  direction = "INGRESS"
  priority  = 1000

  # Только из внутренней подсети
  source_ranges = ["10.0.1.0/24"]

  # Loki порт
  allow {
    protocol = "tcp"
    ports    = ["3100"]
  }

  target_tags = ["grafana"]

  description = "Allow internal access to Loki (Promtail -> Loki)"
}

# Firewall rule: allow internal access to Prometheus
resource "google_compute_firewall" "allow_prometheus_internal" {
  name    = "allow-prometheus-internal"
  network = google_compute_network.app_network.name

  direction = "INGRESS"
  priority  = 1000

  # Только из внутренней подсети
  source_ranges = ["10.0.1.0/24"]

  # Prometheus порт (9090)
  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  target_tags = ["prometheus", "monitoring"]

  description = "Allow internal access to Prometheus for metrics scraping"
}

