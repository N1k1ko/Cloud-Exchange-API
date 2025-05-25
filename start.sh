#!/bin/bash
set -e

# === Зависимости ===
echo "Запуск зависимости"
source ./scripts/install-dependencies.sh

# === Настройки окружения ===
echo "Запуск настройки"
if [[ "${FLAG_APP_SETTINGS:-0}" -eq 1 ]]; then
    echo "Всё уже было настроено"
else
    source ./scripts/init-settings.sh
fi

# === Terraform ===
./scripts/start-terraform.sh