#!/bin/sh
iptables -I INPUT -p tcp --dport 3306 -j ACCEPT #MYSQL
sudo yum -y install mysql-server
sudo /sbin/service mysqld start
sudo chkconfig mysqld on
sudo /usr/bin/mysqladmin -u root password '123456'
