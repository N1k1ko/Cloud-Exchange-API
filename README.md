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
│   ├── app_instance/
│   │   ├── cloud-init.tpl
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
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
```bash
source start.sh
```

### Зависимости
* Terraform 
* Yandex CLI (yc) - полуавтоматически
* ssh-keygen для подключения по SSH

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