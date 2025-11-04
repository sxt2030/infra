# google_compute_global_address.app_lb_ip:
resource "google_compute_global_address" "app_lb_ip" {
  address            = "34.8.238.148"
  address_type       = "EXTERNAL"
  creation_timestamp = "2025-10-31T22:28:13.661-07:00"
  description        = null
  effective_labels   = {}
  id                 = "projects/skillbox-devops-basic/global/addresses/app-lb-ip"
  ip_version         = null
  label_fingerprint  = "42WmSpB8rSM="
  labels             = {}
  name               = "app-lb-ip"
  network            = null
  prefix_length      = 0
  project            = "skillbox-devops-basic"
  purpose            = null
  self_link          = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/addresses/app-lb-ip"
  terraform_labels   = {}
}
