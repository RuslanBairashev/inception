# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && \
	apt-get install -y mariadb-server

# Копируем файлы в папку
COPY ./tools/start.sh ./

EXPOSE 3306

ENTRYPOINT [ "bash", "./start.sh" ]
