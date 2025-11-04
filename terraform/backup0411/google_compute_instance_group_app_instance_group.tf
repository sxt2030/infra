# google_compute_instance_group.app_instance_group:
resource "google_compute_instance_group" "app_instance_group" {
  description = null
  id          = "projects/skillbox-devops-basic/zones/us-west4-c/instanceGroups/app-instance-group"
  instances = [
    "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/zones/us-west4-c/instances/app-server",
  ]
  name      = "app-instance-group"
  network   = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
  project   = "skillbox-devops-basic"
  self_link = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/zones/us-west4-c/instanceGroups/app-instance-group"
  size      = 1
  zone      = "us-west4-c"

  named_port {
    name = "http"
    port = 80
  }
}
