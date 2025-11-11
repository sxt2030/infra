output "load_balancer_ip" {
  description = "Load Balancer external IP address. Его надо прописать в DNS под именем skillbox.avtostrada.kz"
  value       = google_compute_global_address.app_lb_ip.address
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
    value = google_compute_global_address.app_lb_ip.address
    ttl   = 300
  }
}


output "staging_ip" {
  value = module.app_server_staging.instance_ip
}

output "prod_ip" {
  value = module.app_server_prod.instance_ip
}

output "staging_ssh" {
  value = "ssh ${var.ssh_user}@${module.app_server_staging.instance_ip}"
}

output "prod_ssh" {
  value = "ssh ${var.ssh_user}@${module.app_server_prod.instance_ip}"
}


output "gitlab_server_ip" {
  description = "Внешний IP-адрес GitLab-сервера. Не забудьте добавить запись DNS ci.avtostrada.kz с этим IP."
  value       = google_compute_instance.gitlab-server.network_interface[0].access_config[0].nat_ip
}

output "prometheus_ip" {
  description = "Внешний IP-адрес Prometheus. Не забудьте добавить запись DNS monitoring.avtostrada.kz с этим IP."
  value       = google_compute_instance.prometheus_vm.network_interface[0].access_config[0].nat_ip
}

output "grafana_ip" {
  description = "Внешний IP-адрес Grafana. Не забудьте добавить запись DNS grafana.avtostrada.kz с этим IP."
  value       = google_compute_instance.grafana_vm.network_interface[0].access_config[0].nat_ip
}

#output "private_ips" {
#  value = {
#    prometheus       = google_compute_instance.prometheus.network_interface[0].network_ip
#    grafana          = google_compute_instance.grafana.network_interface[0].network_ip
#    app_server_stage = google_compute_instance.app_server_staging.network_interface[0].network_ip
#    app_server_prod  = google_compute_instance.app_server_prod.network_interface[0].network_ip
#  }
#}

