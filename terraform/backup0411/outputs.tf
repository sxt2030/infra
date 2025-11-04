output "app_instance_ip" {
  description = "IP-адрес сервера приложения"
  value       = google_compute_instance.app_server.network_interface[0].network_ip
}

output "gitlab_instance_ip" {
  description = "IP-адрес GitLab сервера"
  value       = google_compute_instance.gitlab_server.network_interface[0].network_ip
}

output "load_balancer_ip" {
  description = "IP адрес балансировщика"
  value       = google_compute_global_address.app_lb_ip.address
}

