# google_compute_firewall.allow_health_check:
resource "google_compute_firewall" "allow_health_check" {
  creation_timestamp = "2025-10-31T22:28:13.612-07:00"
  description        = null
  destination_ranges = []
  direction          = "INGRESS"
  disabled           = false
  id                 = "projects/skillbox-devops-basic/global/firewalls/allow-health-check"
  name               = "allow-health-check"
  network            = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
  priority           = 1000
  project            = "skillbox-devops-basic"
  self_link          = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/firewalls/allow-health-check"
  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16",
  ]
  source_service_accounts = []
  source_tags             = []
  target_service_accounts = []
  target_tags = [
    "http-server",
  ]

  allow {
    ports = [
      "80",
    ]
    protocol = "tcp"
  }
}
