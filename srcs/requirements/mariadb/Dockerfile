# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && \
	apt-get install -y mariadb-server

#VOLUME /var/lib/mysql

# Копируем файлы в папку
#COPY ./conf/mysql.cnf /etc/mysql/conf.d/mysql.cnf
COPY ./tools/start.sh ./

EXPOSE 3306

ENTRYPOINT [ "bash", "./start.sh" ]
# Команды исполняемые контейнером на старте
#CMD ["mysqld"]
