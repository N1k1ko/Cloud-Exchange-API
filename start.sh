#!/bin/bash
set -e

# === Зависимости ===
./scripts/install-dependencies.sh

# === Настройки ===
./scripts/init-settings.sh

echo "🚀 Инициализация Terraform..."
terraform init

echo "📄 Планирование изменений..."
terraform plan -out=tfplan

echo "✅ Применение изменений..."
terraform apply -auto-approve tfplan

echo "🎉 Готово!"
