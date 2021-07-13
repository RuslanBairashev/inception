#!/user/bin/env bash
# Стартуем mysql
service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY 'wordpress';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'%';"
mysql -e "FLUSH PRIVILEGES;"
service mysql stop
#exec bash
exec mysqld