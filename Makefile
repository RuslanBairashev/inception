.DEFAULT_GOAL := help
# Локальный docker-registry для образов
# REGISTRY = registry.git.labs.lc:5000/e.lebed/test
# Выводит описание целей - все, что написано после двойного диеза (##) через пробел
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'
 
##################################################
# Создание docker-образов
##################################################
all-images : ft_nginx ft_db ft_wordpress
 
ft_nginx: ## Создание сжатого docker-образа для контейнера nginx
	docker build -t ft_nginx ./srcs/requirements/nginx

ft_db: ## Создание сжатого docker-образа для контейнера db
	docker build -t ft_db ./srcs/requirements/mariadb

ft_wordpress: ## Создание сжатого docker-образа для контейнера wordpress
	docker build -t ft_wordpress ./srcs/requirements/wordpress

del_nginx:
	cd srcs; docker rmi ft_nginx
  
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
 
console-nginx: ## Подключение к консоли контейнера nginx (пользователь root)
	docker-compose exec nginx bash
 
console-php-fpm: ## Подключение к консоли контейнера php-fmp (пользователь root)
	docker-compose exec php-fpm bash
 
console-node: ## Подключение к консоли контейнера node (пользователь www-data)
	docker-compose run --user www-data --rm node bash