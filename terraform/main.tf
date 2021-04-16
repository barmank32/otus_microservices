provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

resource "yandex_vpc_network" "app" {
  name = "app-vpc"
}


resource "yandex_vpc_subnet" "app-subnet" {
  name = "app-subnet"
  v4_cidr_blocks = ["10.10.0.0/24"]
  zone           = var.zone
  network_id     = yandex_vpc_network.app.id
  route_table_id = yandex_vpc_route_table.app-rt.id
}

resource "yandex_vpc_route_table" "app-rt" {
  network_id = yandex_vpc_network.app.id
  name = "Internet"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "10.10.0.10"
  }
}
