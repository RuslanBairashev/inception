# OS установка (базовый образ)
FROM debian:buster

ARG DB_PASSWORD

# установка пакетов
RUN apt-get update && \
	apt-get install -y \
    curl wget php7.3 php7.3-fpm php7.3-json php7.3-mysqli php7.3-xml php7.3-curl php7.3-iconv php7.3-phar php7.3-redis php7.3-ctype
    # строку выше поменять, тк. она скопирована

# WORDPRESS configuration
##RUN rm -rf /var/www/html
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

#RUN sed -i "s/\${DB_PASSWORD}/${DB_PASSWORD}/g" /var/www/html/wp-config.php

# Открываем порт
EXPOSE 9000

COPY ./start.sh /


#ENTRYPOINT  ["/usr/sbin/php-fpm7.3", "-F", "-R"]
###ENTRYPOINT [ "/usr/sbin/php-fpm7.3" ]
###CMD [ "--nodaemonize" ]
ENTRYPOINT [ "bash", "./start.sh" ]
#CMD /usr/sbin/php-fpm -F
