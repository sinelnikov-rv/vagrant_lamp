#!/bin/bash
PASSWORD='superpass'
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
mysql -uroot -p$PASSWORD -e "CREATE USER 'wordpress'@'172.16.2.11' IDENTIFIED BY 'W0rdpr3ss';GRANT USAGE ON *.* TO 'wordpress'@'172.16.2.11';CREATE DATABASE IF NOT EXISTS wordpress;GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'172.16.2.11';"
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
