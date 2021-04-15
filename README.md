# Проектная работа курса "DevOps практики и инструменты"
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
После развертывания инфраструктуры в Облаке вы можете приступить к работе (доработке) с приложеним. 
### в разработке

## Требования к запуску проекта
- Аккаунт Yandex.Cloud
- terraform
- docker (опционально, аккаунт на docker hub)
- (опционально) Установленный и настроенный docker-compose

# Как запустить проект
## Создание инфраструктуры
### в разработке
## Работа с приложением
### в разработке
## Локальная работа с приложением
Для теста приложения на локальном компьютере используйте docker/docker-compose.yml.
# Мои заметки

https://github.com/express42/search_engine_ui

https://github.com/express42/search_engine_crawler


https://cloud.yandex.ru/docs/cos/concepts/

`sudo journalctl -u yc-container-daemon`
