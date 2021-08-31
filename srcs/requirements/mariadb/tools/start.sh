#!/user/bin/env bash
# Стартуем mysql
service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS ${DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${USER}'@'%' IDENTIFIED BY '${PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"
service mysql stop
#exec bash
exec mysqld #если удалить, то не работает