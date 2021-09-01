# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && \
	apt-get install -y mariadb-server

VOLUME /var/lib/mysql

# Копируем файлы в папку
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init.sql /docker-entrypoint-initdb.d/
COPY ./tools/start.sh ./

EXPOSE 3306

ENTRYPOINT [ "bash", "./start.sh" ]
# Команды исполняемые контейнером на старте
#CMD ["mysqld"]
