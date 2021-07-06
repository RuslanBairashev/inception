# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && apt-get install -y \
    mariadb-server

# Прописываем права доступа к папкам
RUN chown -R www-data:www-data /var/www/html/*

# Копируем скрипты в папку
COPY srcs/*.sh ./

# Открываем 2 порта
EXPOSE 80 443

# Команды исполняемые контейнером на старте
CMD bash start.sh