#!/bin/sh
cd /opt

sudo yum -y install wget
sudo yum -y install java-1.8.0-openjdk

#Setup firewall rules
iptables -F
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8085 -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key

sudo yum -y install jenkins
sudo cp /vagrant/alm-config/jenkins/jenkins.properties /etc/sysconfig/jenkins
sudo service jenkins start
