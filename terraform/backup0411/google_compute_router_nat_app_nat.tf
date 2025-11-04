# google_compute_router_nat.app_nat:
resource "google_compute_router_nat" "app_nat" {
  auto_network_tier                   = "PREMIUM"
  drain_nat_ips                       = []
  enable_dynamic_port_allocation      = false
  enable_endpoint_independent_mapping = false
  endpoint_types = [
    "ENDPOINT_TYPE_VM",
  ]
  icmp_idle_timeout_sec              = 30
  id                                 = "skillbox-devops-basic/us-west4/app-router/app-nat"
  max_ports_per_vm                   = 0
  min_ports_per_vm                   = 0
  name                               = "app-nat"
  nat_ip_allocate_option             = "AUTO_ONLY"
  nat_ips                            = []
  project                            = "skillbox-devops-basic"
  region                             = "us-west4"
  router                             = "app-router"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  tcp_established_idle_timeout_sec   = 1200
  tcp_time_wait_timeout_sec          = 120
  tcp_transitory_idle_timeout_sec    = 30
  udp_idle_timeout_sec               = 30
}
