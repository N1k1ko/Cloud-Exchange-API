#!/bin/bash
set -e

# === Зависимости ===
echo "Запуск зависимости"
source ./scripts/install-dependencies.sh

# === Настройки ===
echo "Запуск настройки"
source ./scripts/init-settings.sh

# === Terraform ===
#./scripts/start-terraform.sh