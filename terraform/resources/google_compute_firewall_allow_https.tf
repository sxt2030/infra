# google_compute_firewall.allow_https:
resource "google_compute_firewall" "allow_https" {
  creation_timestamp = "2025-10-31T22:28:13.728-07:00"
  description        = null
  destination_ranges = []
  direction          = "INGRESS"
  disabled           = false
  id                 = "projects/skillbox-devops-basic/global/firewalls/allow-https"
  name               = "allow-https"
  network            = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
  priority           = 1000
  project            = "skillbox-devops-basic"
  self_link          = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/firewalls/allow-https"
  source_ranges = [
    "0.0.0.0/0",
  ]
  source_service_accounts = []
  source_tags             = []
  target_service_accounts = []
  target_tags = [
    "https-server",
  ]

  allow {
    ports = [
      "443",
    ]
    protocol = "tcp"
  }
}
