#!/bin/bash
set -e

echo "Установка Terraform..."

# Обновляем список пакетов
sudo apt-get update -y

# Устанавливаем зависимости
sudo apt-get install -y curl unzip

# Определяем версию Terraform (последняя стабильная)
TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)

# Если jq не установлен, устанавливаем его
if ! command -v jq &> /dev/null; then
  echo "Устанавливаем jq..."
  sudo apt-get install -y jq
fi

# Скачиваем архив Terraform
curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Распаковываем
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Перемещаем бинарник в /usr/local/bin (требуются права sudo)
sudo mv terraform /usr/local/bin/

# Удаляем архив
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Проверяем версию установленного Terraform
terraform -version

rm ./LICENSE.txt

echo "Terraform установлен успешно!"