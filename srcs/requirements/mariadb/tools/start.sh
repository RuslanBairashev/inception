# Стартуем mysql
service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'admin';"
mysql -e "FLUSH PRIVILEGES;"

# Стартуем php
service php7.3-fpm start

bash