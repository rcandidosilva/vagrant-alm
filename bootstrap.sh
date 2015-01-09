#!/bin/sh
sudo yum -y install wget
sudo yum -y install zip
sudo yum -y install unzip
sudo yum -y install dos2unix
sudo yum -y install nano
sudo yum -y install libyaml-devel
sudo yum -y install zlib-devel
sudo yum -y install curl-devel
sudo yum -y install openssl-devel
sudo yum -y install httpd-devel
sudo yum -y install apr-devel
sudo yum -y install apr-util-devel
sudo yum -y install mysql-devel
sudo yum -y install gcc
sudo yum -y install ruby-devel
sudo yum -y install gcc-c++
sudo yum -y install make
sudo yum -y install postgresql-devel
sudo yum -y install ImageMagick-devel
sudo yum -y install sqlite-devel
sudo yum -y install perl-LDAP
sudo yum -y install mod_perl
sudo yum -y install perl-Digest-SHA

#Setup firewall rules
iptables -F
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save
iptables -L -v

cd /opt

#Download and install softwares

#Install MySQL server
sudo yum -y install mysql
sudo yum -y install mysql-server
sudo chkconfig mysqld on
sudo service mysqld start

#Install Apache
yum -y install httpd
chkconfig httpd on
sudo service httpd start

#Install Redmine
#mysql --user=root --password=root_password_mysql
#create database redmine_db character set utf8;
#create user 'redmine_admin'@'localhost' identified by 'your_new_password';
#grant all privileges on redmine_db.* to 'redmine_admin'@'localhost';
#quit;

#cd /var/www
#wget http://www.redmine.org/releases/redmine-2.5.0.tar.gz

#tar xvfz redmine-2.5.0.tar.gz
#mv redmine-2.5.0 redmine
#rm -rf redmine-2.5.0.tar.gz

#cd /var/www/redmine/config
#cp database.yml.example database.yml

#Install JDK
#sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.rpm
#chmod +x jdk-7u55-linux-x64.rpm
#rpm -ivh jdk-7u55-linux-x64.rpm

#Configure user .bash_profile
echo export JAVA_HOME=\"/usr/java/jdk1.7.0_55/\" >> $HOME/.bashrc
PATH=$JAVA_HOME/bin:$PATH
source $HOME/.bashrc

#Install SonarCube
wget --progress=bar:force --no-cookies --no-check-certificate http://dist.sonar.codehaus.org/sonarqube-4.5.2.zip
unzip sonarqube-4.5.2.zip

sudo ln -s /opt/sonarqube-4.5.2/bin/linux-x86-64/sonar.sh /usr/bin/sonar
sudo cp /vagrant/replacement_files/sonar /etc/init.d/sonar
sudo chmod 755 /etc/init.d/sonar
sudo chkconfig --add sonar
sudo cp -f /vagrant/replacement_files/sonar.properties /opt/sonarqube-4.5.2/conf
sudo mysql < /vagrant/scripts/sonar.sql

/etc/init.d/sonar start

#Install Jenkins
sudo wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
sudo java -jar jenkins.war &

#Install Nexus
sudo wget http://download.sonatype.com/nexus/oss/nexus-2.11.1-01-bundle.zip
