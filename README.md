# Cloud-Exchange-API
FastAPI в Yandex Cloud с Terraform    
Этот проект разворачивает FastAPI-приложение с PostgreSQL и Object Storage в Yandex Cloud, используя Terraform.

Структура проекта
```css
terraform/
├── modules
│   ├── app
│   │   ├── declaration.yaml
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── postgres
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── storage
│   │   ├── main.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── main.tf
├── outputs.tf
└── variables.tf
```

## Развёртывание
### Зависимости (установить если требуется)
* Terraform 
```bash
bash ./scripts/terraform-install.sh
```
* Yandex CLI (yc) + профиль
```bash
bash ./scripts/yc-install.sh
exec -l $SHELL
yc init
```
* ssh-keygen для подключения по SSH
```bash
bash ./scripts/generate_ssh.sh
```

## Настройки Terraform
```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
source ./scripts/yc-env.sh
```
Вручную заполнить terraform/terraform.tfvars

## Запуск Terraform
```bash
cd terraform/
terraform init
terraform apply
```

## Проверка
После apply терраформа получить IP ВМ:
```bash
terraform output
```
Открыть IP в браузере

## Удаление
```bash
terraform destroy
```