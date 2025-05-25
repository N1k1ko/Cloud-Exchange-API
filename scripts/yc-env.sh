#!/bin/bash
set +e

# === Настраиваемые переменные ===
SERVICE_ACCOUNT_NAME="app-admin"
FOLDER_ID=$(yc config get folder-id)
ROLE="storage.editor"  # Или storage.admin

# === Проверяем, существует ли сервисный аккаунт ===
SA_INFO=$(yc iam service-account get "$SERVICE_ACCOUNT_NAME" 2>&1)

# === Проверяем, есть ли ошибка "not found" ===
if echo "$SA_INFO" | grep -q "not found"; then

  # === Создание сервисного аккаунта ===
  echo "Создаю сервисный аккаунт: $SERVICE_ACCOUNT_NAME"
  SA_ID=$(yc iam service-account create --name "$SERVICE_ACCOUNT_NAME" --folder-id "$FOLDER_ID" | grep ^id | awk '{print $2}')

  # === Назначение роли для сервисного аккаунта ===
  echo "Назначаю роль '$ROLE' для сервисного аккаунта"
  yc resource-manager folder add-access-binding \
    --id "$FOLDER_ID" \
    --role "$ROLE" \
    --service-account-id $SA_ID

else
  # === Извлекаем ID из вывода ===
  SA_ID=$(echo "$SA_INFO" | grep '^id:' | awk '{print $2}')
  echo "Сервисный аккаунт '$SERVICE_ACCOUNT_NAME' найден."
  echo "ID сервисного аккаунта: $SA_ID"
fi

# === Получение токенов ===
YC_TOKEN=$(yc iam create-token)
YC_CLOUD_ID=$(yc config get cloud-id)
YC_FOLDER_ID=$(yc config get folder-id)

# === Создание static access key ===
echo "Создаю static access key"
KEYS=$(yc iam access-key create --service-account-id "$SA_ID")
ACCESS_KEY=$(echo "$KEYS" | grep key_id | awk '{print $2}')
SECRET_KEY=$(echo "$KEYS" | grep secret | awk '{print $2}')

echo "Токены и ключи доступа экспортированы в переменные окружения"

export TF_VAR_yc_cloud_id=$YC_CLOUD_ID
export TF_VAR_yc_folder_id=$YC_FOLDER_ID
export TF_VAR_yc_token=$YC_TOKEN
export TF_VAR_access_key=$ACCESS_KEY
export TF_VAR_secret_key=$SECRET_KEY
