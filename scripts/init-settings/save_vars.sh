#!/bin/bash

# Переменные для экспорта
export_vars=(
    # === YandexCLI профиль для terraform ===
    "TF_VAR_yc_token=$TF_VAR_yc_token"
    "TF_VAR_yc_cloud_id=$TF_VAR_yc_cloud_id"
    "TF_VAR_yc_folder_id=$TF_VAR_yc_folder_id"

    # === Сервисный аккаунт ===
    "TF_VAR_bucket_name=$TF_VAR_bucket_name"
    "TF_VAR_access_key=$TF_VAR_access_key"
    "TF_VAR_secret_key=$TF_VAR_secret_key"

    # === Настройки PostgreSQL ===
    "TF_VAR_db_name=$TF_VAR_db_name"
    "TF_VAR_db_user=$TF_VAR_db_user"
    "TF_VAR_db_password=$TF_VAR_db_password"

    # === Зоны и докер образ ===
    "TF_VAR_zone=$TF_VAR_zone"
    "TF_VAR_docker_image=$TF_VAR_docker_image"

    # === Настройки приложения ===
    "TF_VAR_app_admin_name=$TF_VAR_app_admin_name"

    # === Флаг настроек ===
    "FLAG_APP_SETTINGS=$FLAG_APP_SETTINGS"
)

# Файл конфигурации оболочки, куда добавим переменные
bashrc_file="$HOME/.bashrc"

# Добавим переменные, если их нет в файле
for var in "${export_vars[@]}"; do
  var_name="${var%%=*}"
  if ! grep -q "^export $var_name=" "$bashrc_file"; then
    echo "export $var" >> "$bashrc_file"
    echo "Добавлена переменная $var_name в $bashrc_file"
  else
    echo "Переменная $var_name уже есть в $bashrc_file"
  fi
done