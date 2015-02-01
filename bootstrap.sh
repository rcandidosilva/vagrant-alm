#!/bin/sh
sudo yum -y install wget
sudo yum -y install java-1.8.0-openjdk
#Install MySQL server
/vagrant/bootstrap-mysql.sh
#Install Jenkins
/vagrant/bootstrap-jenkins.sh
#Install Sonar
/vagrant/bootstrap-sonar.sh
#Install Nexus
/vagrant/bootstrap-nexus.sh
#Install Gitblit
/vagrant/bootstrap-gitblit.sh
#Setup firewall rules
iptables -F
iptables -A INPUT -p tcp --dport 22 -j ACCEPT #SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT #HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT #HTTPS
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v
