terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_network" "app" {
  name = "exchange-api-network"
}

resource "yandex_vpc_subnet" "app" {
  name           = "exchange-api-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.app.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
