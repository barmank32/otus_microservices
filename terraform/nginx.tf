resource "yandex_compute_instance" "nginx" {
  name = "nginx"
  hostname = "nginx"

  zone = var.zone
  platform_id = "standard-v2"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      size = 10
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    docker-container-declaration = file("nginx.yml")
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
    source      = "files/nginx.conf"
    destination = "/tmp/nginx.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /nginx",
      "sudo cp /tmp/nginx.conf /nginx",
      "sudo chmod ugo+wr /nginx/nginx.conf"
    ]
  }

}
