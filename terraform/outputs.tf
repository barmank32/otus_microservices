output "Crawler_ui" {
  value = "http://${yandex_compute_instance.crawler-ui.network_interface.0.nat_ip_address}:8000"
}
output "Rabbitmq_management" {
  value = "http://${yandex_compute_instance.rabbitmq.network_interface.0.nat_ip_address}:15672"
}
output "Prometheus" {
  value = "http://${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}:9090"
}
output "Grafana" {
  value = "http://${yandex_compute_instance.monitoring.network_interface.0.nat_ip_address}:3000"
}
