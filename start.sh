#!/bin/bash
set -e

# === Зависимости ===
echo "Запуск зависимости"
./scripts/install-dependencies.sh

# === Настройки ===
echo "Запуск настройки"
./scripts/init-settings.sh

# === Настройки ===
echo "Запуск терраформ"

echo "🚀 Инициализация Terraform..."
terraform init

echo "📄 Планирование изменений..."
terraform plan -out=tfplan

echo "✅ Применение изменений..."
terraform apply -auto-approve tfplan

echo "🎉 Готово!"
