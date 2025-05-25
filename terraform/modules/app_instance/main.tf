terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

resource "yandex_compute_instance" "app_vm" {
  name        = var.instance_name
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores         = 4      # увеличить число ядер CPU (например, с 2 до 4)
    memory        = 8      # увеличить оперативную память в ГБ (например, с 2 до 8)
    core_fraction = 100    # увеличить выделенную долю CPU (максимум 100)
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      size     = 20  # размер диска 20 ГБ
      type     = "network-ssd"  # для SSD
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
    docker-container-declaration = templatefile("${path.module}/declaration.yaml", {
    docker_image = var.docker_image
    env_vars     = var.env_vars
  })
    #user-data = file("${path.module}/cloud_config.yaml")
  }
}