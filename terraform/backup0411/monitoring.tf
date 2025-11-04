# ===== Monitoring Server (Prometheus + Grafana) =====

resource "google_compute_address" "monitoring_ip" {
  count  = var.create_monitoring ? 1 : 0
  name   = "monitoring-server-ip"
  region = var.region
}

resource "google_compute_instance" "monitoring" {
  count        = var.create_monitoring ? 1 : 0
  name         = "monitoring-server"
  machine_type = var.monitoring_machine_type
  zone         = var.zone

  tags = ["monitoring-server", "web-server", "monitored-server", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.monitoring_disk_size
      type  = "pd-standard"
    }
  }

  network_interface {
    network = data.google_compute_network.default.name
    access_config {
      nat_ip = google_compute_address.monitoring_ip[0].address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y python3 python3-pip
  EOF

  scheduling {
    preemptible       = var.use_preemptible
    automatic_restart = !var.use_preemptible
  }
}
