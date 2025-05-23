variable "network_id" {}
variable "subnet_id" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {
  sensitive = true
}
