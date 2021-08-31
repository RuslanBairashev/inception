#!/user/bin/env bash
# Стартуем mysql
service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"
service mysql stop
#exec bash
exec mysqld #если удалить, то не работает