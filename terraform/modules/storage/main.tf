terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_storage_bucket" "static_files" {
  bucket     = var.bucket_name
  access_key = var.access_key
  secret_key = var.secret_key

  anonymous_access_flags {
    read = true
    list = false
  }
}
