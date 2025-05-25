variable "bucket_name" {
  description = "Название бакета в Object Storage"
  type        = string
}

variable "access_key" {
  description = "Access Key для Object Storage"
  type        = string
}

variable "secret_key" {
  description = "Secret Key для Object Storage"
  type        = string
  sensitive   = true
}
