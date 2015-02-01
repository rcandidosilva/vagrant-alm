#!/bin/sh
iptables -A INPUT -p tcp --dport 8085 -j ACCEPT

cd /opt
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key

sudo yum -y install jenkins
sudo cp /vagrant/alm-config/jenkins/jenkins.properties /etc/sysconfig/jenkins
sudo service jenkins start
