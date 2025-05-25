#!/bin/bash

# === Terraform ===
if ! command -v terraform &> /dev/null; then
    ./scripts/dependencies/terraform-install.sh
fi

echo "Terraform установлен:"
terraform version
echo ""

# === YandexCLI ===
if ! command -v terraform &> /dev/null; then
    ./scripts/dependencies/terraform-install.sh
fi

echo "YandexCLI установлен:"
yc version
echo ""

# === Проверка текущей конфигурации YandexCLI ===
if [ ! -f "$HOME/.config/yandex-cloud/config.yaml" ]; then
  echo "Конфигурация Yandex Cloud не найдена. Запуск yc init..."
  yc init
fi

# === SSH key ===
./scripts/dependencies/generate_ssh.sh