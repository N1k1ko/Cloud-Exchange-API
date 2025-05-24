variable "name" {
  description = "Имя ВМ"
  type        = string
}

variable "zone" {
  description = "Зона размещения"
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_id" {
  description = "ID подсети"
  type        = string
}

variable "public_key" {
  description = "SSH-публичный ключ"
  type        = string
}

variable "platform_id" {
  description = "Платформа ВМ"
  type        = string
  default     = "standard-v1"
}