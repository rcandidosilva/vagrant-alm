#!/bin/sh
iptables -A INPUT -p tcp --dport 8087 -j ACCEPT #GITBLIT
iptables -A INPUT -p tcp --dport 8088 -j ACCEPT #GITBLIT

sudo mkdir -p /opt/gitblit;
cd /opt/gitblit;
echo "Downloading Gitblit..."
sudo wget -nv http://dl.bintray.com/gitblit/releases/gitblit-1.6.2.tar.gz
sudo tar -zxf gitblit-1.6.2.tar.gz;
sudo rm gitblit-1.6.2.tar.gz;

sudo cp /vagrant/alm-config/gitblit/gitblit.properties /opt/gitblit/data/gitblit.properties
sudo cp /vagrant/alm-config/gitblit/service-centos.sh /etc/init.d/gitblit
sudo chkconfig --add gitblit
sudo service gitblit  start
