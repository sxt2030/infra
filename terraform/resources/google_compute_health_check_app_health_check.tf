# google_compute_health_check.app_health_check:
resource "google_compute_health_check" "app_health_check" {
  check_interval_sec  = 5
  creation_timestamp  = "2025-10-31T02:00:59.952-07:00"
  description         = null
  healthy_threshold   = 2
  id                  = "projects/skillbox-devops-basic/global/healthChecks/app-health-check"
  name                = "app-health-check"
  project             = "skillbox-devops-basic"
  self_link           = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/healthChecks/app-health-check"
  source_regions      = []
  timeout_sec         = 5
  type                = "HTTP"
  unhealthy_threshold = 2

  http_health_check {
    host               = null
    port               = 80
    port_name          = null
    port_specification = null
    proxy_header       = "NONE"
    request_path       = "/health"
    response           = null
  }

  log_config {
    enable = false
  }
}
