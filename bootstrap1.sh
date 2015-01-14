#!/bin/sh
sudo yum -y install wget
sudo yum -y install java-1.8.0-openjdk

#Setup firewall rules
iptables -F
iptables -A INPUT -p tcp --dport 22 -j ACCEPT #SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT #HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT #MYSQL
iptables -A INPUT -p tcp --dport 8086 -j ACCEPT #SONAR
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v

cd /opt

#Install MySQL server

sudo yum -y install mysql
sudo yum -y install mysql-server
sudo chkconfig mysqld on
sudo service mysqld start

sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sudo yum -y install sonar

sudo mysql -u root -p < /vagrant/alm-config/sonar/create_database.sql
sudo cp /vagrant/alm-config/sonar/sonar.properties /opt/sonar/conf/sonar.properties
sudo ln -s /opt/sonar/bin/linux-x86-64/sonar.sh /usr/bin/sonar
sudo chkconfig --add sonar
sudo service sonar start
