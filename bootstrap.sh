#!/bin/sh
cd /opt

sudo yum -y install wget
sudo yum -y install java-1.8.0-openjdk

#Setup firewall rules
iptables -F
iptables -A INPUT -p tcp --dport 22 -j ACCEPT #SSH
iptables -A INPUT -p tcp --dport 80 -j ACCEPT #HTTP
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -p tcp --dport 3306 -j ACCEPT #MYSQL
iptables -A INPUT -p tcp --dport 8085 -j ACCEPT #JENKINS
iptables -A INPUT -p tcp --dport 8086 -j ACCEPT #SONAR
iptables -A INPUT -p tcp --dport 8087 -j ACCEPT #GITBLIT
iptables -A INPUT -p tcp --dport 8088 -j ACCEPT #GITBLIT
iptables -A INPUT -p tcp --dport 8089 -j ACCEPT #NEXUS
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v

#Install MySQL server
sudo yum -y install mysql-server
sudo /sbin/service mysqld start
sudo chkconfig mysqld on
/usr/bin/mysqladmin -u root password '123456'

#Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key

sudo yum -y install jenkins
sudo cp /vagrant/alm-config/jenkins/jenkins.properties /etc/sysconfig/jenkins
sudo service jenkins start

#Install Sonar
sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
sudo yum -y install sonar
sudo mysql -u root -p123456 < /vagrant/alm-config/sonar/create_database.sql
sudo cp /vagrant/alm-config/sonar/sonar.properties /opt/sonar/conf/sonar.properties
sudo ln -s /opt/sonar/bin/linux-x86-64/sonar.sh /usr/bin/sonar
sudo chkconfig --add sonar
sudo service sonar start

#Install Nexus
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

#Install Gitblit
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
