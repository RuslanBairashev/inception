#! /bin/bash
echo "[mysqld]" >> /etc/mysql/mariadb.cnf
echo "bind-address = 0.0.0.0" >> /etc/mysql/mariadb.cnf
echo "[client]" >> /etc/mysql/mariadb.cnf
echo "user=root" >> /etc/mysql/mariadb.cnf
echo "password=123" >> /etc/mysql/mariadb.cnf
service mysql start
#sleep 5
mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%';"
mysql -u root --skip-password -e "UPDATE mysql.user set plugin='mysql_native_password' WHERE user = 'root' ;"
#echo "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE} " | mariadb
#echo "CREATE USER 'wordpress'@'%' IDENTIFIED BY '${DB_PASSWORD}';" | mariadb
#echo "GRANT ALL ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';" | mariadb
###echo "UPDATE mysql.user set plugin='mysql_native_password' WHERE user = 'root' ;" | mariadb
###echo "UPDATE mysql.user set plugin='mysql_native_password' WHERE user = '${DB_USER}' ;" | mariadb
#echo "FLUSH PRIVILEGES;" | mariadb
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"
###echo "ALTER USER '${DB_USER}' IDENTIFIED BY '${DB_PASSWORD}';" | mariadb
service mysql stop
mysqld