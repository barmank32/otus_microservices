provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

data "yandex_compute_image" "container-optimized-image" {
  family    = "container-optimized-image"
}

resource "yandex_compute_instance" "mongo-db" {
  name = "mongo-db"
  hostname = "mongo-db"

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
    docker-container-declaration = file("mongo.yml")
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "yandex_compute_instance" "rabbitmq" {
  name = "rabbitmq"
  hostname = "rabbitmq"

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
    docker-container-declaration = file("rabbitmq.yml")
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "yandex_compute_instance" "crawler" {
  name = "crawler"
  hostname = "crawler"

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
    docker-container-declaration = file("crawler.yml")
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  depends_on = [
    yandex_compute_instance.mongo-db,
    yandex_compute_instance.rabbitmq
  ]
}

resource "yandex_compute_instance" "crawler-ui" {
  name = "crawler-ui"
  hostname = "crawler-ui"

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
    docker-container-declaration = file("crawler-ui.yml")
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  depends_on = [
    yandex_compute_instance.mongo-db
  ]
}