# google_compute_firewall.allow_ssh:
resource "google_compute_firewall" "allow_ssh" {
  creation_timestamp = "2025-10-31T22:28:13.706-07:00"
  description        = null
  destination_ranges = []
  direction          = "INGRESS"
  disabled           = false
  id                 = "projects/skillbox-devops-basic/global/firewalls/allow-ssh"
  name               = "allow-ssh"
  network            = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
  priority           = 1000
  project            = "skillbox-devops-basic"
  self_link          = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/firewalls/allow-ssh"
  source_ranges = [
    "0.0.0.0/0",
  ]
  source_service_accounts = []
  source_tags             = []
  target_service_accounts = []
  target_tags = [
    "ssh-server",
  ]

  allow {
    ports = [
      "22",
    ]
    protocol = "tcp"
  }
}
