terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_mdb_postgresql_cluster" "app" {
  name        = "exchange-app-database"
  environment = "PRODUCTION"
  network_id  = var.network_id

  config {
    version = "16"
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-hdd"
      disk_size          = 10
    }
  }

  host {
    zone      = var.zone
    subnet_id = var.subnet_id
  }
}

resource "yandex_mdb_postgresql_user" "app" {
  cluster_id = yandex_mdb_postgresql_cluster.app.id
  name       = var.db_user
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "app" {
  depends_on = [yandex_mdb_postgresql_user.app]
  cluster_id = yandex_mdb_postgresql_cluster.app.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.app.name
}
