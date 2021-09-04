#! /bin/bash
echo "[client]" >> /etc/mysql/my.cnf
echo "user=root" >> /etc/mysql/my.cnf
echo "password=${DB_ROOT_PASSWORD}" >> /etc/mysql/mariadb.cnf
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf

service mysql start
mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%';"
mysql -u root --skip-password -e "UPDATE mysql.user set plugin='mysql_native_password' WHERE user = 'root' ;"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"
service mysql stop
mysqld