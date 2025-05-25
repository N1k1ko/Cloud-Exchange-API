#!/bin/bash
set -e

echo "Установка Yandex CLI..."

# Загружаем официальный скрипт установки и запускаем
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

export PATH="$HOME/yandex-cloud/bin:$PATH"