.DEFAULT_GOAL := help
# Локальный docker-registry для образов
# REGISTRY = registry.git.labs.lc:5000/e.lebed/test
# Выводит описание целей - все, что написано после двойного диеза (##) через пробел
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
 
##################################################
# Создание docker-образов
##################################################
obr_all : obr_nginx obr_db obr_wordpress
 
obr_nginx: ## Создание сжатого docker-образа для контейнера nginx
	docker build -t obr_nginx ./srcs/requirements/nginx

obr_db: ## Создание сжатого docker-образа для контейнера db
	docker build -t obr_db ./srcs/requirements/mariadb

obr_wordpress: ## Создание сжатого docker-образа для контейнера wordpress
	docker build -t obr_wordpress ./srcs/requirements/wordpress

drop_all: drop_nginx drop_db drop_wordpress

drop_nginx:
	cd srcs; docker rmi obr_nginx

drop_db:
	cd srcs; docker rmi obr_db

drop_wordpress:
	cd srcs; docker rmi obr_wordpress

##################################################
# Запуск docker-образов
##################################################

run_nginx:
	docker run --name con_nginx --rm -it -p obr_wordpress:obr_wordpress -p 443:443 obr_nginx

run_wordpress:
	docker run --name con_wordpress --rm -it -p 9000:9000 obr_wordpress

####################################################################################################
# Управление контейнерами с помощью docker-compose
####################################################################################################
build: ## Сборка docker-образов согласно инструкциям из docker-compose.yml
	docker-compose build
 
up: ## Создание и запуск docker-контейнеров, описанных в docker-compose.yml
	cd srcs; docker-compose up -d
 
down: ## Остановка и УДАЛЕНИЕ docker-контейнеров, описанных в docker-compose.yml
	cd srcs; docker-compose down
 
stop: ## Остановка docker-контейнеров, описанных в docker-compose.yml
	cd srcs; docker-compose stop
 
start: ## Запуск docker-контейнеров, описанных в docker-compose.yml
	cd srcs; docker-compose start
 
####################################################################################################
# Подключение к консоли контейнеров (контейнеры должны быть запущены)
####################################################################################################
console-workspace: ## Подключение к консоли контейнера workspace (пользователь www-data)
	docker-compose exec --user www-data workspace bash
 
exec_nginx: ## Подключение к консоли контейнера nginx
	docker exec -it con_nginx bash

exec_wordpress: ## Подключение к консоли контейнера nginx
	docker exec -it con_wordpress bash

console-php-fpm: ## Подключение к консоли контейнера php-fmp (пользователь root)
	docker-compose exec php-fpm bash
 
console-node: ## Подключение к консоли контейнера node (пользователь www-data)
	docker-compose run --user www-data --rm node bash