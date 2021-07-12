# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && \
	apt-get install -y \
    php7.3 php7.3-fpm php7.3-mysqli php7.3-mbstring

# WORDPRESS configuration
# Download from internet
##ADD https://wordpress.org/latest.tar.gz /var/www/files/
##RUN cd /var/www/files/ && tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
# Download from local distributive
COPY ./distrib/latest.tar.gz /var/www/files/
RUN cd /var/www/files/ && tar -xzvf latest.tar.gz

COPY ./conf/wp-config.php /var/www/wordpress/wordpress

# Прописываем права доступа к папкам
#RUN chown -R www-data:www-data /var/www/wordpress/*

# Открываем 2 порта
EXPOSE 9000

COPY ./start.sh /

ENTRYPOINT [ "sh", "start.sh" ]
#CMD /usr/sbin/php-fpm -F
