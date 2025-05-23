#!/bin/bash

# === Настраиваемые переменные ===
BUCKET_NAME="my-app-static-$(date +%s)"
SERVICE_ACCOUNT_NAME="sa-object-storage-$(date +%s)"
FOLDER_ID=$(yc config get folder-id)
ROLE="storage.editor"  # Или storage.admin

# === 1. Создание сервисного аккаунта ===
echo "Создаю сервисный аккаунт: $SERVICE_ACCOUNT_NAME"
SA_ID=$(yc iam service-account create --name "$SERVICE_ACCOUNT_NAME" --folder-id "$FOLDER_ID" | grep ^id | awk '{print $2}')

# === 2. Назначение роли для сервисного аккаунта ===
echo "Назначаю роль '$ROLE' для сервисного аккаунта"
yc resource-manager folder add-access-binding \
  --id "$FOLDER_ID" \
  --role "$ROLE" \
  --service-account-id $SA_ID

# === 3. Создание static access key ===
echo "Создаю static access key"
KEYS=$(yc iam access-key create --service-account-id "$SA_ID")
ACCESS_KEY=$(echo "$KEYS" | grep key_id | awk '{print $2}')
SECRET_KEY=$(echo "$KEYS" | grep secret | awk '{print $2}')

# === 4. Создание бакета ===
echo "Создаю бакет: $BUCKET_NAME"
yc storage bucket create --name "$BUCKET_NAME"

# === 5. Вывод итоговых данных ===
echo ""
echo "Объектное хранилище создано:"
echo "bucket_name = \"$BUCKET_NAME\""
echo "access_key  = \"$ACCESS_KEY\""
echo "secret_key  = \"$SECRET_KEY\""