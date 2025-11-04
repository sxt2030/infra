# google_compute_backend_service.app_backend:
resource "google_compute_backend_service" "app_backend" {
  affinity_cookie_ttl_sec         = 0
  compression_mode                = null
  connection_draining_timeout_sec = 300
  creation_timestamp              = "2025-10-31T02:02:13.658-07:00"
  custom_request_headers          = []
  custom_response_headers         = []
  description                     = null
  edge_security_policy            = null
  enable_cdn                      = false
  fingerprint                     = "QTp9S7zH8o8="
  generated_id                    = 8075295305683813882
  health_checks = [
    "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/healthChecks/app-health-check",
  ]
  id                    = "projects/skillbox-devops-basic/global/backendServices/app-backend-service"
  load_balancing_scheme = "EXTERNAL"
  locality_lb_policy    = null
  name                  = "app-backend-service"
  port_name             = "http"
  project               = "skillbox-devops-basic"
  protocol              = "HTTP"
  security_policy       = null
  self_link             = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/backendServices/app-backend-service"
  service_lb_policy     = null
  session_affinity      = "NONE"
  timeout_sec           = 10

  backend {
    balancing_mode               = "UTILIZATION"
    capacity_scaler              = 1
    description                  = null
    group                        = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/zones/us-west4-c/instanceGroups/app-instance-group"
    max_connections              = 0
    max_connections_per_endpoint = 0
    max_connections_per_instance = 0
    max_rate                     = 0
    max_rate_per_endpoint        = 0
    max_rate_per_instance        = 0
    max_utilization              = 0
  }
}
