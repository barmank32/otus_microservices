# Проектная работа курса "DevOps практики и инструменты"
## Видео
    Инсталяция
    https://disk.yandex.ru/i/wOMidiieXnk8bg
    Деплой
    https://disk.yandex.ru/i/acJ6e9UzOvKI-A
## Описание

Для создания CI/CD системы было выдано простое микросервисное приложение:

    https://github.com/express42/search_engine_crawler
    https://github.com/express42/search_engine_ui

## Иструменты и технологии
В проекте в той или иной мере используются:
- Yandex Cloud как платформа для Instance
- Container Optimized Image от Yandex как основа для запуска контейнеров
- Terraform для развертывания Instance в Облаке
- Docker-compose для тестирования работы приложения в локальном окружении и запуска некоторых COI
- Docker
- Gitlab-CI + некоторая обертка bash как основная CI/CD система
- EFK-stack (Elasticsearch, fluentd, Kibana) для создания системы логирования.
- Prometheus + Grafana для сбора и визуализации метрик
- MongoDB как БД для хранения данных приложения search_engine
- RabbitMQ как менеджер очередей для приложения search_engine

## Схема работы проекта
После развертывания инфраструктуры в Облаке вы можете приступить к работе (доработке) с приложением. При создании инфраструктуры, разворачивается готовая система для отладки приложения. При каждом комите происходит  новая сборка и деплой приложения.

## Требования к запуску проекта
- Аккаунт Yandex.Cloud
- terraform
- docker (опционально, аккаунт на docker hub)
- (опционально) Установленный и настроенный docker-compose

# Как запустить проект
## Создание инфраструктуры
В паке `terraform` запустить
```
terraform init
terraform apply
```
После развертывания инфраструктуры terraform сообщит по каким ссылкам можно проводить тестирование.
## Работа с приложением
Доступ к приложению можно получить по указанной в предыдущем пункте ссылке. Если у вас есть необходимость изменить/доработать приложение, просто внесите изменения и запушьте изменения в Git-репозиторий.
Исходные коды приложения находятся в:

    docker/search_engine_crawler
    docker/search_engine_ui

Gitlab-ci проведет необходимые тесты приложения, если все в порядке, создаст новый build и произведет деплой новой версии приложения.

## Локальная работа с приложением
Для теста приложения на локальном компьютере используйте docker/docker-compose.yml.


