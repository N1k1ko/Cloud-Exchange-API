#!/bin/bash
echo "Запуск терраформ"
cd terraform

echo "🚀 Инициализация Terraform..."
terraform init

echo "📄 Планирование изменений..."
terraform plan -out=tfplan

echo "✅ Применение изменений..."
terraform apply -auto-approve tfplan

rm -f tfplan

echo "🎉 Готово!"
cd -