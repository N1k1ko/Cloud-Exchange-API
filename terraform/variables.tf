variable "zone" {}
variable "docker_image" {
  type        = string
}

variable "app_host" {
  type        = string
}
variable "app_port" {
  type        = string
}
variable "app_admin_name" {
  type        = string
 }

variable "yc_token" {}
variable "yc_cloud_id" {}
variable "yc_folder_id" {}

variable "db_name" {
  default     = "appdb"
}
variable "db_user" {
  default     = "appuser"
}
variable "db_password" {
  sensitive = true
}

variable "bucket_name" {}
variable "access_key" {}
variable "secret_key" {
  sensitive = true
}