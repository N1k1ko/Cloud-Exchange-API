# Yandex Cloud
variable "yc_token" {
  description = "Токен для доступа к Yandex Cloud"
  type        = string
}
variable "yc_cloud_id" {
  description = "Идентификатор облака Yandex"
  type        = string
}
variable "yc_folder_id" {
  description = "Идентификатор папки Yandex"
  type        = string
}
variable "zone" {
  description = "Зона доступности ru-central1-[a,b,c]"
  type        = string
}
variable "app_image_tag"{
  description = "ID Docker образа приложения"
  type        = string
}
variable "ssh_key"{
  description = "SSH публичный ключ для доступа к ВМ"
  type        = string
}

# Бакет
variable "bucket_name" {
  description = "Имя бакета"
  type        = string
}
variable "access_key" {
  description = "Ключ доступа к бакету"
  type        = string
}
variable "secret_key" {
  description = "Секретный ключ доступа к бакету"
  type        = string
}

# Приложение
variable "app_admin_name" {
  description = "Имя администратора приложения"
  type        = string
}
variable "app_admin_key" {
  description = "Ключ администратора приложения"
  type        = string
}

# База данных
variable "db_name" {
  description = "Имя базы данных приложения"
  type        = string
}
variable "db_user" {
  description = "Имя пользователя базы данных приложения"
  type        = string
}
variable "db_password" {
  description = "Пароль пользователя базы данных приложения"
  type        = string
}
