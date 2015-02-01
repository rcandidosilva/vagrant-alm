#!/bin/sh
iptables -A INPUT -p tcp --dport 8089 -j ACCEPT #NEXUS

sudo mkdir -p /opt/nexus
cd /opt/nexus
#warning: whether change version replace NEXUS_HOME variable in nexus/nexus
echo "Downloading Nexus..."
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
