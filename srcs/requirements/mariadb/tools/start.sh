#!/user/bin/env bash
# Стартуем mysql
service mysqld start
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';"
mysql -e "FLUSH PRIVILEGES;"
exec mysqld
