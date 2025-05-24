variable "instance_name" {
  type        = string
  description = "Имя ВМ"
}

variable "zone" {
  type        = string
  description = "Зона размещения"
}

variable "subnet_id" {
  type        = string
  description = "ID подсети"
}

variable "image_id" {
  type        = string
  description = "ID образа ОС"
}

variable "ssh_public_key" {
  type        = string
  description = "Публичный SSH ключ"
}

variable "docker_image" {
  type        = string
  description = "Образ из Container Registry"
}

variable "env_vars" {
  type        = map(string)
  description = "Переменные окружения для Docker контейнера"
}
