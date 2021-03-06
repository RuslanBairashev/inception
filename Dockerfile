# OS установка (базовый образ)
FROM debian:buster

# установка пакетов
RUN apt-get update && apt-get install -y \
    nginx \
    php7.3 php-fpm php-mysql php-mbstring \
    mariadb-server \
    wget

# NGINX configuration (удаляем index файл)
RUN rm var/www/html/index.nginx-debian.html

# копируем свои настройки nginx
COPY srcs/default /etc/nginx/sites-available/default

# SSL
# openssl: базовый инструмент командной строки для создания и управления сертификатами, ключами и другими файлами OpenSSL.
# req: эта подкоманда указывает, что на данном этапе нужно использовать запрос на подпись сертификата X.509 (CSR). X.509 – это стандарт инфраструктуры открытого ключа, которого придерживаются SSL и TLS при управлении ключами и сертификатами. То есть, данная команда позволяет создать новый сертификат X.509.
# -x509: эта опция вносит поправку в предыдущую субкоманду, сообщая утилите о том, что вместо запроса на подписание сертификата необходимо создать самоподписанный сертификат.
# -nodes: пропускает опцию защиты сертификата парольной фразой. Нужно, чтобы при запуске сервер Nginx имел возможность читать файл без вмешательства пользователя. Установив пароль, придется вводить его после каждой перезагрузки.
# -days 365: эта опция устанавливает срок действия сертификата (как видите, в данном случае сертификат действителен в течение года).
# -newkey rsa:2048: эта опция позволяет одновременно создать новый сертификат и новый ключ. Поскольку ключ, необходимый для подписания сертификата, не был создан ранее, нужно создать его вместе с сертификатом. Данная опция создаст ключ RSA на 2048 бит.
# -keyout: эта опция сообщает OpenSSL, куда поместить сгенерированный файл ключа.
# -out: сообщает OpenSSL, куда поместить созданный сертификат.
# -SHA-2 (англ. Secure Hash Algorithm Version 2 — безопасный алгоритм хеширования, версия 2) — семейство криптографических алгоритмов — однонаправленных хеш-функций, включающее в себя алгоритмы SHA-224, SHA-256, SHA-384, SHA-512, SHA-512/256 и SHA-512/224.
RUN openssl req -x509 -sha256 -nodes -days 150 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj '/C=RU/L=Kazan/O=21School/OU=R&D/CN=localhost'

# PHPMYADMIN configuration
# Download from internet
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz && \
    tar -xzvf phpMyAdmin-5.0.4-english.tar.gz && \
    mv phpMyAdmin-5.0.4-english/ /var/www/html/phpmyadmin && \
    rm -rf phpMyAdmin-5.0.4-english.tar.gz
# Download from local distributive
# COPY distrib/phpMyAdmin-5.0.4-english/ /var/www/html/phpmyadmin

# WORDPRESS configuration
# Download from internet
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm -rf latest.tar.gz
# Download from local distributive
# COPY distrib/wordpress-5.6.1 /var/www/html/
COPY srcs/wp-config.php /var/www/html/wordpress

# Прописываем права доступа к папкам
RUN chown -R www-data:www-data /var/www/html/*

# Копируем скрипты в папку
COPY srcs/*.sh ./

# Открываем 2 порта
EXPOSE 80 443

# Команды исполняемые контейнером на старте
CMD bash start.sh