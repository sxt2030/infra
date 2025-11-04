# ===== Application Server =====

resource "google_compute_address" "app_ip" {
  count  = var.create_app_server ? 1 : 0
  name   = "app-server-ip"
  region = var.region
}

resource "google_compute_instance" "app_server" {
  count        = var.create_app_server ? 1 : 0
  name         = "app-server"
  machine_type = var.app_machine_type
  zone         = var.zone

  tags = ["app-server", "web-server", "monitored-server", "docker-host", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.app_disk_size
      type  = "pd-standard"
    }
  }

  network_interface {
    network = data.google_compute_network.default.name
    access_config {
      nat_ip = google_compute_address.app_ip[0].address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y python3 python3-pip docker.io
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ubuntu
    
    # Install Python Docker module for Ansible
    apt-get install -y python3-docker
  EOF

  scheduling {
    preemptible       = var.use_preemptible
    automatic_restart = !var.use_preemptible
  }
}
