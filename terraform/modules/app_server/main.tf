resource "google_compute_instance" "app_server" {
  name         = "app-server-${var.environment}"
  machine_type = var.machine_type
  zone         = var.gcp_zone

  tags = ["http-server", "https-server", "ssh-server", var.environment]

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group" "app_instance_group" {
  name = "app-instance-group-${var.environment}"
  zone = var.gcp_zone

  instances = [google_compute_instance.app_server.id]

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_health_check" "app_health_check" {
  name = "app-health-check-${var.environment}"

  http_health_check {
    port         = 80
    request_path = "/health"
  }

  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

output "instance_group_id" {
  value = google_compute_instance_group.app_instance_group.id
}

output "health_check_id" {
  value = google_compute_health_check.app_health_check.id
}


