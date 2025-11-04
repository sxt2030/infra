# ===== Firewall Rules =====

# SSH access for all servers
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
}

# HTTP/HTTPS for web servers
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# GitLab specific ports
resource "google_compute_firewall" "allow_gitlab" {
  name    = "allow-gitlab"
  network = data.google_compute_network.default.name
  count   = var.create_gitlab ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = ["8080", "8081", "8082"] # GitLab, Registry, Pages
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlab-server"]
}

# Application port
resource "google_compute_firewall" "allow_app" {
  name    = "allow-app"
  network = data.google_compute_network.default.name
  count   = var.create_app_server ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["app-server"]
}

# Prometheus & Grafana
resource "google_compute_firewall" "allow_monitoring" {
  name    = "allow-monitoring"
  network = data.google_compute_network.default.name
  count   = var.create_monitoring ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = ["9090", "3000"] # Prometheus, Grafana
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["monitoring-server"]
}

# Node Exporter (for Prometheus scraping)
resource "google_compute_firewall" "allow_node_exporter" {
  name    = "allow-node-exporter"
  network = data.google_compute_network.default.name
  count   = var.create_monitoring ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["monitored-server"]
}

# Docker communication between servers
resource "google_compute_firewall" "allow_docker" {
  name    = "allow-docker"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["2375", "2376"] # Docker daemon
  }

  source_tags = ["docker-host"]
  target_tags = ["docker-host"]
}
