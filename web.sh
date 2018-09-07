#!/bin/bash
DB='wordpress'
DB_USER='wordpress'
DB_PASS='W0rdpr3ss'
DB_HOST='172.16.2.10'
sudo apt-get update
sudo apt-get -y install apache2 php php-mysql libapache2-mod-php
cd /tmp
wget https://wordpress.org/latest.tar.gz 2> /dev/null
sudo tar xzf latest.tar.gz -C /var/www/
sudo rm -f latest.tar.gz
sudo chown -R www-data:www-data /var/www/
sudo sed -i 's/html/wordpress/' /etc/apache2/sites-enabled/000-default.conf
sudo service apache2 restart
curl --data "dbname=$DB&uname=$DB_USER&pwd=$DB_PASS&dbhost=$DB_HOST&prefix=wp_&language=&submit=Submit" http://172.16.2.11/wp-admin/setup-config.php?step=2 > /dev/null 2>&1
curl --data "weblog_title=wordpress&user_name=root&admin_password=W0rdpr3ss&admin_password2=W0rdpr3ss&admin_email=test@test.ru&Submit=Install+WordPress" http://172.16.2.11/wp-admin/install.php?step=2 > /dev/null 2>&1
