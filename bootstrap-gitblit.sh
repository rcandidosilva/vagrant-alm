#!/bin/sh
cd /opt

sudo yum -y install wget
sudo yum -y install java-1.8.0-openjdk

iptables -F
iptables -A INPUT -p tcp --dport 22   -j ACCEPT #SSH
iptables -A INPUT -p tcp --dport 80   -j ACCEPT #HTTP
iptables -A INPUT -p tcp --dport 443  -j ACCEPT #HTTPS
iptables -A INPUT -p tcp --dport 8087 -j ACCEPT #GITBLIT
iptables -A INPUT -p tcp --dport 8088 -j ACCEPT #GITBLIT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v

sudo mkdir -p /opt/gitblit;
cd /opt/gitblit;
sudo wget http://dl.bintray.com/gitblit/releases/gitblit-1.6.2.tar.gz
sudo tar -zxf gitblit-1.6.2.tar.gz;

sudo cp /vagrant/alm-config/gitblit/gitblit.properties /opt/gitblit/data/gitblit.properties
sudo cp /vagrant/alm-config/gitblit/service-centos.sh /etc/init.d/gitblit
sudo chkconfig --add gitblit
sudo service gitblit  start
