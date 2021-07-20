# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y mariadb-server

VOLUME /var/lib/mysql

USER root



COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/init.sql /docker-entrypoint-initdb.d/

# Копируем скрипты в папку
COPY tools/start.sh ./

EXPOSE 3306

ENTRYPOINT [ "bash", "./start.sh" ]
# Команды исполняемые контейнером на старте
#CMD ["mysqld"]
