# inception
https://www.youtube.com/watch?v=lXajYKBWrQ0&ab_channel=Shchepotin

https://www.youtube.com/watch?v=-2I4123TW4E&ab_channel=ITtipsandtricks

Сообщение для закрепа с полезными ссылками. 
Изучите, что такое VirtualBox
https://poznyaev.ru/blog/linux/debian-v-virualbox
https://docs.docker.com/engine/install/debian/
https://docs.docker.com/compose/install/
https://docs.docker.com/engine/install/linux-postinstall/
Если проблемы с sudo: https://milq.github.io/enable-sudo-user-account-debian/
Добавление ssh для комфортной работы: https://losst.ru/nastrojka-ssh-v-debian + https://wiki.debian.org/ru/DHCP_Client

https://mariadb.com/kb/en/creating-a-custom-docker-image/

Wordpress Server Environment
https://make.wordpress.org/hosting/handbook/server-environment/

https://www.youtube.com/watch?v=j1FAZ0bUEvs

Сборка на базовых образах:
https://admin812.ru/razvertyvanie-wordpress-s-nginx-php-fpm-i-mariadb-s-pomoshhyu-docker-compose.html

Описание настроек nginx
https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose-ru

PHP config for wp:
COPY ./conf/php-fpm.conf /etc/php/7.3/fpm/pool.d/www.conf
123
https://www.linux.org.ru/forum/admin/14522855
https://stackoverflow.com/questions/37313780/how-can-i-start-php-fpm-in-a-docker-container-by-default/44409813
Entrypoint fo wordpress:
ENTRYPOINT  ["/usr/sbin/php-fpm7.3", "-F", "-R"]


