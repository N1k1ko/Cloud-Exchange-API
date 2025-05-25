variable "zone" {
  description = "Зона доступности ru-central1-[a,b,c]"
  type        = string
}

variable "network_id" {
  description = "Идентификатор сети"
  type        = string
}

variable "subnet_id" {
  description = "Идентификатор подсети"
  type        = string
}

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
