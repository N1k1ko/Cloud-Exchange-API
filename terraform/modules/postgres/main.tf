terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_mdb_postgresql_cluster" "this" {
  name        = "fastapi-pg"
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
    zone      = "ru-central1-a"
    subnet_id = var.subnet_id
  }
}

resource "yandex_mdb_postgresql_user" "user" {
  cluster_id = yandex_mdb_postgresql_cluster.this.id
  name       = var.db_user
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "db" {
  depends_on = [yandex_mdb_postgresql_user.user]
  
  cluster_id = yandex_mdb_postgresql_cluster.this.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.user.name
}
