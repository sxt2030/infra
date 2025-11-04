# google_compute_subnetwork.app_subnet:
resource "google_compute_subnetwork" "app_subnet" {
  creation_timestamp         = "2025-10-31T02:01:12.687-07:00"
  description                = null
  external_ipv6_prefix       = null
  gateway_address            = "10.0.1.1"
  id                         = "projects/skillbox-devops-basic/regions/us-west4/subnetworks/app-subnet"
  internal_ipv6_prefix       = null
  ip_cidr_range              = "10.0.1.0/24"
  ipv6_access_type           = null
  ipv6_cidr_range            = null
  name                       = "app-subnet"
  network                    = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
  private_ip_google_access   = false
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "skillbox-devops-basic"
  purpose                    = "PRIVATE"
  region                     = "us-west4"
  role                       = null
  secondary_ip_range         = []
  self_link                  = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/regions/us-west4/subnetworks/app-subnet"
  stack_type                 = "IPV4_ONLY"
}
