# Cloud-Exchange-API


FastAPI в Yandex Cloud с Terraform    
Этот проект разворачивает FastAPI-приложение с PostgreSQL и Object Storage в Yandex Cloud, используя Terraform.

Состав проекта
* main.tf — описание инфраструктуры (БД, сеть, инстанс и т.д.)
* variables.tf — объявление переменных
* terraform.tfvars.example — пример значений переменных
* docker-compose.yml + Dockerfile — FastAPI-приложение с БД
* FastAPI-код — внутри директории app/

## Развёртывание
### 1. Установи зависимости
* Terraform [bash terraform-install.sh]
* Yandex CLI (yc) [bash yc-install.sh && yc init]
* ssh-keygen для подключения по SSH (если нет ключа)

```bash
ssh-keygen -t rsa -b 4096
```

### 2. Настрой доступ
Сохрани свои значения в terraform.tfvars:

```bash
cp infra/terraform/terraform.tfvars.example infra/terraform/terraform.tfvars
```
Заполни:
* yc_token, yc_cloud_id, yc_folder_id — из yc config list
* db_password, access_key, secret_key — безопасные значения
* bucket_name, access_key, secret_key - из yc-create-bucket.sh или уже созданного Object Storage
* git_repo — публичный Git-репозиторий с docker-compose.yml

### 3. Запуск Terraform
```bash
terraform init       # Инициализация
terraform plan       # Просмотр плана
terraform apply      # Применение
```

## Проверка
После apply терраформа получи IP ВМ:
```bash
terraform output
```
Открой IP в браузере