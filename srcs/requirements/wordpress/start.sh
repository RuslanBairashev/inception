#!/user/bin/env bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp user create dictator dictator@example.com --role=administrator --user_pass=tropico
wp user create bob bob@example.com --role=author --user_pass=alice

mkdir -p /run/php
touch /run/php/php7-fpm.pid
exec php-fpm7.3 --nodaemonize
#exec php -S localhost:9000