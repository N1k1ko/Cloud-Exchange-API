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

resource "yandex_compute_instance" "app" {
  name        = var.instance_name
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
      size     = 15
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

metadata = {
    ssh-keys = "admin:${var.ssh_public_key}"
    docker-container-declaration = templatefile("${path.module}/declaration.yaml", {
    docker_image = var.docker_tag
    env_vars     = var.env_vars
  })
  }
}
