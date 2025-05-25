#!/bin/bash
set +e

if [[ "${FLAG_APP_SETTINGS:-0}" -eq 1 ]]; then
    return 0
fi

# === YandexCLI профиль для terraform ===
export TF_VAR_yc_token=$(yc iam create-token)
export TF_VAR_yc_cloud_id=$(yc config get cloud-id)
export TF_VAR_yc_folder_id=$(yc config get folder-id)

# === Сервисный аккаунт ===
source ./scripts/init-settings/yc-init-service-account.sh

# === Настройки PostgreSQL ===
export TF_VAR_db_name="appdb"
export TF_VAR_db_user="appuser"
export TF_VAR_db_password="strong-password"

# === Зоны и докер образ ===
export TF_VAR_zone="ru-central1-a"
export TF_VAR_docker_image="cr.yandex/crpf9fimok8vnj8h3skl/exchange-api:latest"

# Настроки приложения
export TF_VAR_app_admin_name="admin"

# === Флаг настроек ===
export FLAG_APP_SETTINGS=1

# === Сохранить ===
source ./scripts/init-settings/save_vars.sh