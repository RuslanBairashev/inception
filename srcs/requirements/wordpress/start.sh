#!/user/bin/env bash

##curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x ./wp-cli.phar
#sudo mv ./wp-cli.phar /usr/local/bin/wp
cp ./wp-cli.phar /usr/local/bin/wp
wp core install --allow-root --url=rmerrie.42.fr --title=inception --admin_user=dictator --admin_password=tropico --admin_email=b@weww.com --path=/var/www/html
wp user create bob bob@example.com --allow-root --role=author --user_pass=alice --path=/var/www/html

mkdir -p /run/php
touch /run/php/php7-fpm.pid
exec php-fpm7.3 --nodaemonize
#exec php -S localhost:9000