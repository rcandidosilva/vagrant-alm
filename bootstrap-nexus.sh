#!/bin/sh

sudo yum -y install wget
sudo yum -y install java-1.8.0-openjdk

iptables -F
iptables -A INPUT -p tcp --dport 22   -j ACCEPT #SSH
iptables -A INPUT -p tcp --dport 80   -j ACCEPT #HTTP
iptables -A INPUT -p tcp --dport 443  -j ACCEPT #HTTPS
iptables -A INPUT -p tcp --dport 8089 -j ACCEPT #NEXUS
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v

sudo mkdir -p /opt/nexus
cd /opt/nexus
#warning: whether change version replace NEXUS_HOME variable in nexus/nexus
sudo wget -nv http://download.sonatype.com/nexus/oss/nexus-2.11.1-01-bundle.tar.gz
sudo tar -zxf nexus*.tar.gz
sudo rm nexus*.tar.gz

sudo useradd nexus -p nexus
sudo chown nexus:nexus /opt/nexus/ -R

sudo cp /vagrant/alm-config/nexus/nexus /opt/nexus/nexus-*/bin/nexus
sudo cp /vagrant/alm-config/nexus/nexus.properties /opt/nexus/nexus-*/conf/nexus.properties
sudo cp /vagrant/alm-config/nexus/nexus /etc/init.d/nexus
sudo chkconfig --add nexus
sudo service nexus start
