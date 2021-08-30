#!/user/bin/env bash

chmod -R 775 /var/www/html/*
chown -R www-data /var/www/html/*
chgrp -R www-data /var/www/html/*

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x ./wp-cli.phar
#sudo mv ./wp-cli.phar /usr/local/bin/wp
cp ./wp-cli.phar /usr/local/bin/wp
wp core install --allow-root --url=localhost --title=43 --admin_user=bobik --admin_email=b@weww.com --path=/var/www/html
wp user create dictator dictator@example.com --role=administrator --user_pass=tropico --allow-root --path=/var/www/html
wp user create bob bob@example.com --role=author --user_pass=alice --allow-root --path=/var/www/html

mkdir -p /run/php
touch /run/php/php7-fpm.pid
exec php-fpm7.3 --nodaemonize
#exec php -S localhost:9000