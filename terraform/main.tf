terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.95"
    }
  }
  required_version = ">= 1.5.0"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.zone
}

module "vpc" {
  source = "./modules/vpc"
}

module "postgres" {
  source        = "./modules/postgres"
  network_id    = module.vpc.network_id
  subnet_id     = module.vpc.subnet_id
  db_name       = var.db_name
  db_user       = var.db_user
  db_password   = var.db_password
}

module "storage" {
  source      = "./modules/storage"
  bucket_name = var.bucket_name
  access_key  = var.access_key
  secret_key  = var.secret_key
}

module "app_instance" {
  source = "./modules/app_instance"

  instance_name   = "fastapi-vm"
  zone            = var.zone
  subnet_id       = module.vpc.subnet_id
  image_id        = "fd85u0rct32prepgjlv0" # Ubuntu 22.04 LTS (пример)
  ssh_public_key  = file("~/.ssh/id_rsa.pub")
  docker_image    = var.docker_image

  env_vars = {
    APP__RUN__HOST              = var.app_host
    APP__RUN__PORT              = var.app_port
    APP__DB__HOST               = module.postgres.pg_cluster_hosts[0]
    APP__DB__PORT               = "6432"
    APP__DB__USERNAME           = var.db_user
    APP__DB__PASSWORD           = var.db_password
    APP__DB__NAME               = var.db_name
    APP__DEFAULT_ADMIN__NAME    = var.app_admin_name
    APP__DEFAULT_ADMIN__API_KEY = "3489da3e-1c5e-4ba6-bd8b-f7cc2e9c0d23"
  }
}