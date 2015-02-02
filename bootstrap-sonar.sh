#!/bin/sh
iptables -A INPUT -p tcp --dport 8086 -j ACCEPT #SONAR

cd /opt
sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sudo yum -y install sonar
sudo mysql -u root -p123456 < /vagrant/alm-config/sonar/create_database.sql
sudo cp /vagrant/alm-config/sonar/sonar.properties /opt/sonar/conf/sonar.properties
sudo ln -s /opt/sonar/bin/linux-x86-64/sonar.sh /usr/bin/sonar
sudo chkconfig --add sonar
sudo service sonar start
