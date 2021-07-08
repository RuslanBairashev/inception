# OS установка (базовый образ)
FROM debian:buster
#FROM wordpress:php7.1-apache
#COPY . /var/www/html
# установка пакетов
RUN apt-get update && \
	apt-get install -y \
    wordpress \
    php-fpm
   # wget


# WORDPRESS configuration
# Download from internet
#RUN wget https://wordpress.org/latest.tar.gz && \
#    tar -xzvf latest.tar.gz && \
#    mv wordpress /var/www/html/ && \
#    rm -rf latest.tar.gz
# Download from local distributive
# COPY distrib/wordpress-5.6.1 /var/www/html/
# COPY ./requirements/wordpress/conf/wp-config.php /var/www/html/wordpress

# Прописываем права доступа к папкам
#RUN chown -R www-data:www-data /var/www/html/*

# Открываем 2 порта
EXPOSE 3306 9000

CMD php-fpm
