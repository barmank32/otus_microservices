resource "yandex_compute_instance" "monitoring" {
  name     = "monitoring"
  hostname = "monitoring"

  zone        = var.zone
  platform_id = "standard-v2"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat       = false
  }

  allow_stopping_for_update = true

  metadata = {
    docker-compose = file("spec/monitoring.yml")
    ssh-keys       = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    agent = true

    bastion_host        = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
    bastion_user        = "ubuntu"
    bastion_private_key = file(var.privat_key_path)

    host = self.network_interface.0.ip_address
    user = "ubuntu"
  }

  provisioner "file" {
    source      = "files/monitoring"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    script = "files/monitoring.sh"
  }

}
