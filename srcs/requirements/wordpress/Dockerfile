# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && \
	apt-get install -y \
    php7.3 php7.3-fpm php7.3-mysql

# WORDPRESS configuration
RUN rm -rf /var/www/html
# Download from internet
##ADD https://wordpress.org/latest.tar.gz /var/www
##RUN cd /var/www/ && tar -xzvf latest.tar.gz && rm -rf latest.tar.gz
# Download from local distributive
COPY ./distrib/latest.tar.gz /var/www/
RUN cd /var/www/ && tar -xzvf latest.tar.gz
RUN mv /var/www/wordpress /var/www/html
COPY ./conf/wp-config.php /var/www/html
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d

# Прописываем права доступа к папкам
#RUN chown -R www-data:www-data /var/www/wordpress/*

# Открываем 2 порта
EXPOSE 9000

COPY ./start.sh /

ENTRYPOINT [ "bash", "start.sh" ]
#CMD /usr/sbin/php-fpm -F
