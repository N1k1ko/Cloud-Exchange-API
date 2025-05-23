# Cloud-Exchange-API

FastAPI в Yandex Cloud с Terraform    
Этот проект разворачивает FastAPI-приложение с PostgreSQL и Object Storage в Yandex Cloud, используя Terraform.

Структура проекта
```css
terraform/
├── main.tf                # Подключение модулей
├── variables.tf           # Глобальные переменные
├── outputs.tf             # Глобальные outputs
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── postgres/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── storage/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

## Развёртывание
### 1. Установи зависимости
* Terraform 
```bash
./scripts/terraform-install.sh
```
* Yandex CLI (yc)
```bash
./scripts/yc-install.sh && yc init
```
* ssh-keygen для подключения по SSH (если нет ключа)
```bash
ssh-keygen -t rsa -b 4096
```

### 2. Настрой доступ
Сохрани свои значения в terraform.tfvars:

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```
Заполни:
* yc_token, yc_cloud_id, yc_folder_id — из yc config list
* db_password, access_key, secret_key — безопасные значения
* bucket_name, access_key, secret_key - из (./scripts/yc-create-service-account.sh) или уже созданного service account
* git_repo — публичный Git-репозиторий с docker-compose.yml

### 3. Запуск Terraform
```bash
cd ./terraform
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

## Удаление
```bash
terraform destroy
```