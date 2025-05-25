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
  source        = "./modules/vpc"

  zone          = var.zone
}

module "postgres" {
  source        = "./modules/postgres"

  zone          = var.zone
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

module "app" {
  source = "./modules/app"

  instance_name   = "exchange-app"
  zone            = var.zone
  subnet_id       = module.vpc.subnet_id
  ssh_public_key  = var.ssh_key
  docker_tag      = var.app_image_tag

  env_vars = {
    APP__RUN__HOST              = "0.0.0.0"
    APP__RUN__PORT              = "80"
    APP__DB__HOST               = module.postgres.pg_cluster_hosts[0]
    APP__DB__PORT               = "6432"
    APP__DB__USERNAME           = var.db_user
    APP__DB__PASSWORD           = var.db_password
    APP__DB__NAME               = var.db_name
    APP__DEFAULT_ADMIN__NAME    = var.app_admin_name
    APP__DEFAULT_ADMIN__API_KEY = var.app_admin_key
  }
}
