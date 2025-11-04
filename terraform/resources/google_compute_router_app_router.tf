# google_compute_router.app_router:
resource "google_compute_router" "app_router" {
  creation_timestamp            = "2025-10-31T22:28:14.472-07:00"
  description                   = null
  encrypted_interconnect_router = false
  id                            = "projects/skillbox-devops-basic/regions/us-west4/routers/app-router"
  name                          = "app-router"
  network                       = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
  project                       = "skillbox-devops-basic"
  region                        = "us-west4"
  self_link                     = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/regions/us-west4/routers/app-router"
}
