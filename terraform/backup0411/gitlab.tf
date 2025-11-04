# ===== GitLab Server =====

resource "google_compute_address" "gitlab_ip" {
  count  = var.create_gitlab ? 1 : 0
  name   = "gitlab-server-ip"
  region = var.region
}

resource "google_compute_instance" "gitlab" {
  count        = var.create_gitlab ? 1 : 0
  name         = "gitlab-server"
  machine_type = var.gitlab_machine_type
  zone         = var.zone

  tags = ["gitlab-server", "web-server", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.gitlab_disk_size
      type  = "pd-standard"
    }
  }

  network_interface {
    network = data.google_compute_network.default.name
    access_config {
      nat_ip = google_compute_address.gitlab_ip[0].address
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

# ===== GitLab Runner =====

resource "google_compute_instance" "gitlab_runner" {
  count        = var.create_gitlab ? 1 : 0
  name         = "gitlab-runner"
  machine_type = var.gitlab_runner_machine_type
  zone         = var.zone

  tags = ["gitlab-runner", "docker-host", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    network = data.google_compute_network.default.name
    access_config {}
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
  EOF

  scheduling {
    preemptible       = var.use_preemptible
    automatic_restart = !var.use_preemptible
  }
}
