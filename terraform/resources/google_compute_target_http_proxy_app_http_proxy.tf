# google_compute_target_http_proxy.app_http_proxy:
resource "google_compute_target_http_proxy" "app_http_proxy" {
  creation_timestamp          = "2025-10-31T02:03:26.829-07:00"
  description                 = null
  http_keep_alive_timeout_sec = 0
  id                          = "projects/skillbox-devops-basic/global/targetHttpProxies/app-http-proxy"
  name                        = "app-http-proxy"
  project                     = "skillbox-devops-basic"
  proxy_bind                  = false
  proxy_id                    = 744329199961621937
  self_link                   = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/targetHttpProxies/app-http-proxy"
  url_map                     = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/urlMaps/app-url-map"
}
