output "Crawler_ui" {
  value = "http://${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"
}
output "Rabbitmq_management" {
  value = "http://${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}:8080"
}
output "Prometheus" {
  value = "http://${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}:9090"
}
output "Grafana" {
  value = "http://${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}:3000"
}
