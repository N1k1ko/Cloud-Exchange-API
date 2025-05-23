# Авторизационные данные для доступа к Yandex Cloud
variable "yc_token" {
  description = "OAuth-токен или IAM-токен Yandex Cloud"
}
variable "yc_cloud_id" {
  description = "ID облака в Yandex Cloud"
}
variable "yc_folder_id" {
  description = "ID папки в Yandex Cloud"
}

# Параметры базы данных PostgreSQL
variable "db_name" {
  description = "Имя базы данных"
  default     = "appdb"
}
variable "db_user" {
  description = "Имя пользователя для БД"
  default     = "appuser"
}
variable "db_password" {
  description = "Пароль пользователя для БД"
}

# Параметры бакета Object Storage
variable "bucket_name" {
  description = "Имя бакета в Object Storage"
}
variable "access_key" {
  description = "Access key для Object Storage"
}
variable "secret_key" {
  description = "Secret key для Object Storage"
}

# Git-репозиторий с исходниками приложения и docker-compose.yml
variable "git_repo" {
  description = "Ссылка на публичный репозиторий с приложением"
}