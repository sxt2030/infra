output "load_balancer_ip" {
  description = "Load Balancer external IP address. Его надо прописать в DNS под именем skillbox.avtostrada.kz"
  value       = google_compute_global_forwarding_rule.app_forwarding_rule.ip_address
}

output "server_external_ip" {
  description = "Server external IP address."
  value       = google_compute_instance.app_server.network_interface[0].access_config[0].nat_ip
}

output "server_internal_ip" {
  description = "Server internal IP address"
  value       = google_compute_instance.app_server.network_interface[0].network_ip
}

output "full_domain" {
  description = "Full domain name for the application"
  value       = "${var.subdomain}.${var.root_domain}"
}

output "dns_configuration" {
  description = "DNS A record to add to your domain registrar"
  value = {
    type  = "A"
    name  = var.subdomain
    value = google_compute_global_forwarding_rule.app_forwarding_rule.ip_address
    ttl   = 300
  }
}

output "ssh_command" {
  description = "SSH command to connect to server"
  value       = "ssh ${var.ssh_user}@${google_compute_instance.app_server.network_interface[0].access_config[0].nat_ip}"
}

output "gitlab_server_ip" {
  description = "Внешний IP-адрес GitLab-сервера. Не забудьте добавить запись DNS ci.avtostrada.kz с этим IP."
  value       = google_compute_instance.gitlab-server.network_interface[0].access_config[0].nat_ip
}

