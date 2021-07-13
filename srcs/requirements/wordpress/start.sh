#!/user/bin/env bash

mkdir -p /run/php
touch /run/php/php7.3-fpm.pid
exec php-fpm7.3 --nodaemonize
#exec php -S localhost:9000