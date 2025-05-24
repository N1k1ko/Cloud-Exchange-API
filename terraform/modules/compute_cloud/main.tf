terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_compute_instance" "vm_nginx" {
  name        = var.name
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id      = var.subnet_id
    nat            = true
    nat_ip_address = null
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
    user-data = <<EOF
#cloud-config
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
EOF
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}