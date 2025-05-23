terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_network" "this" {
  name = "fastapi-network"
}

resource "yandex_vpc_subnet" "this" {
  name           = "fastapi-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["10.0.1.0/24"] # Диапазон IP-адресов
}