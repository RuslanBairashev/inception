.DEFAULT_GOAL := help
# Локальный docker-registry для образов
# REGISTRY = registry.git.labs.lc:5000/e.lebed/test
# Выводит описание целей - все, что написано после двойного диеза (##) через пробел
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
 
##################################################
# Создание docker-образов
##################################################
all : nginx db wordpress
 
nginx: ## Создание сжатого docker-образа для контейнера nginx
	docker build -t nginx ./srcs/requirements/nginx

db: ## Создание сжатого docker-образа для контейнера db
	docker build -t db ./srcs/requirements/mariadb

wordpress: ## Создание сжатого docker-образа для контейнера wordpress
	docker build -t wordpress ./srcs/requirements/wordpress

drop_all: drop_nginx drop_db drop_wordpress

drop_nginx:
	cd srcs; docker rmi nginx

drop_db:
	cd srcs; docker rmi db

drop_wordpress:
	cd srcs; docker rmi wordpress

##################################################
# Запуск docker-образов
##################################################

run_nginx:
	docker run --name con_nginx --rm -it -p 80:80 -p 443:443 nginx

run_wordpress:
	docker run --name con_wordpress --rm -it wordpress

run_db:
	docker run --name con_db --rm -it -p 3306:3306 db

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

exec_db: ## Подключение к консоли контейнера db
	docker exec -it con_db bash

console-php-fpm: ## Подключение к консоли контейнера php-fmp (пользователь root)
	docker-compose exec php-fpm bash
 
console-node: ## Подключение к консоли контейнера node (пользователь www-data)
	docker-compose run --user www-data --rm node bash

####################################################################################################
# ___
####################################################################################################
redo_volumes: ## 
	sudo rm -rf /home/eternity/data; mkdir -p /home/eternity/data/db_data; mkdir /home/eternity/data/wordpress_data;

start_eval: ## 
	docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
