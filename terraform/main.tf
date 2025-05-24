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

module "compute_cloud" {
  source     = "./modules/compute_cloud"
  name       = "compute_cloud"
  zone       = var.zone
  subnet_id  = module.vpc.subnet_id
  public_key = file("~/.ssh/id_rsa.pub")
}