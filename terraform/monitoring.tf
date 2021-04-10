resource "yandex_compute_instance" "monitoring" {
  name = "monitoring"
  hostname = "monitoring"

  zone = var.zone
  platform_id = "standard-v2"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      size = 20
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.monitoring-data.id
    device_name = "monitoring-data"
    mode = "READ_WRITE"
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  allow_stopping_for_update = true

  metadata = {
    docker-compose = file("monitoring.yml")
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.privat_key_path)
  }

  provisioner "file" {
    source      = "files/configs"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  depends_on = [
    yandex_compute_disk.monitoring-data
  ]
}

resource "yandex_compute_disk" "monitoring-data" {
  name     = "monitoring-data"
  type     = "network-ssd"
  zone     = var.zone
  size = 10
}