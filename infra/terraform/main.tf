# Подключение к провайдеру Yandex Cloud
provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a" # Используемая зона размещения
}

# Создание виртуальной сети
resource "yandex_vpc_network" "fastapi_net" {
  name = "fastapi-network"
}

# Подсеть внутри созданной сети
resource "yandex_vpc_subnet" "fastapi_subnet" {
  name           = "fastapi-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.fastapi_net.id
  v4_cidr_blocks = ["10.0.1.0/24"] # Диапазон IP-адресов
}

# Кластер PostgreSQL (управляемый)
resource "yandex_mdb_postgresql_cluster" "pg_cluster" {
  name        = "fastapi-pg"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.fastapi_net.id

  config {
    version = "16" # Версия PostgreSQL
    resources {
      resource_preset_id = "s2.micro"   # Минимальные ресурсы
      disk_type_id       = "network-hdd"
      disk_size          = 10 # Размер в ГБ
    }
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.fastapi_subnet.id
  }
}

# Создание базы данных внутри кластера
resource "yandex_mdb_postgresql_database" "app_db" {
  cluster_id = yandex_mdb_postgresql_cluster.pg_cluster.id
  name       = var.db_name
  owner      = var.db_user
}

# Пользователь БД
resource "yandex_mdb_postgresql_user" "app_user" {
  cluster_id = yandex_mdb_postgresql_cluster.pg_cluster.id
  name       = var.db_user
  password   = var.db_password
}

# Object Storage для хранения статики
resource "yandex_storage_bucket" "static_files" {
  bucket = var.bucket_name
  access_key = var.access_key
  secret_key = var.secret_key

  anonymous_access_flags {
    read = true  # Позволяет анонимно читать статические файлы (например, изображения)
    list = false # Запрет на просмотр списка файлов
  }
}

# Compute Instance для развёртывания приложения через docker-compose
resource "yandex_compute_instance" "fastapi_instance" {
  name        = "fastapi-docker"
  zone        = "ru-central1-a"
  platform_id = "standard-v1"

  resources {
    cores  = 2    # Количество CPU
    memory = 2    # ОЗУ в ГБ
  }

  boot_disk {
    initialize_params {
      image_id = "fd87n7p7ae2rbv1qqctb" # Docker-совместимый образ Yandex Cloud
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.fastapi_subnet.id
    nat       = true # Включение доступа в интернет
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}" # SSH-доступ для управления
    user-data = <<-EOF
      #cloud-config
      runcmd:
        - apt update
        - apt install -y docker.io docker-compose
        - git clone ${var.git_repo} app
        - cd app
        - docker-compose up -d
    EOF
  }
}