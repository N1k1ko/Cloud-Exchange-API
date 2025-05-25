#!/bin/bash
set -e

# Путь и имя ключа
KEY_NAME=${1:-~/.ssh/id_rsa}

# Проверка существования ключа
if [ -f "$KEY_NAME" ]; then
  echo "SSH ключ уже существует: $KEY_NAME"
else
  echo "Создание SSH ключа: $KEY_NAME"
  ssh-keygen -t rsa -b 4096 -f "$KEY_NAME" -N ""
  echo "Готово. Публичный ключ:"
  cat "${KEY_NAME}.pub"
fi