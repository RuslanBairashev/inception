# OS установка (базовый образ)
FROM debian:buster

ARG DB_PASSWORD

# установка пакетов
RUN apt-get update && \
	apt-get install -y \
    curl wget php7.3 php7.3-cli php7.3-fpm php7.3-opcache \
	php7.3-curl php7.3-mbstring php7.3-zip php7.3-xml php7.3-mysqli

# Download from internet
##ADD https://wordpress.org/latest.tar.gz /var/www
##RUN cd /var/www/ && tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
# Download from local distributive
COPY ./distrib/latest.tar.gz /var/www/
RUN cd /var/www/ && tar -xzvf latest.tar.gz
RUN mv /var/www/wordpress /var/www/html

RUN mkdir -p /run/php
RUN touch /run/php/php7.3-fpm.pid
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

# Прописываем права доступа к папкам
RUN chown -R www-data:www-data /var/www/html/* && \
chmod -R 775 /var/www/html/*

# Открываем порт
EXPOSE 9000

COPY ./tools/start.sh /

ENTRYPOINT [ "bash", "./start.sh" ]
