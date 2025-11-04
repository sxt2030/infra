# google_compute_global_forwarding_rule.app_forwarding_rule:
resource "google_compute_global_forwarding_rule" "app_forwarding_rule" {
  base_forwarding_rule  = null
  description           = null
  effective_labels      = {}
  id                    = "projects/skillbox-devops-basic/global/forwardingRules/app-forwarding-rule"
  ip_address            = "34.8.241.140"
  ip_protocol           = "TCP"
  ip_version            = null
  label_fingerprint     = "42WmSpB8rSM="
  labels                = {}
  load_balancing_scheme = "EXTERNAL"
  name                  = "app-forwarding-rule"
  network               = null
  port_range            = "80-80"
  project               = "skillbox-devops-basic"
  psc_connection_id     = null
  psc_connection_status = null
  self_link             = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/forwardingRules/app-forwarding-rule"
  source_ip_ranges      = []
  subnetwork            = null
  target                = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/targetHttpProxies/app-http-proxy"
  terraform_labels      = {}
}
