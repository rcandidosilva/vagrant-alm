#!/bin/sh
#sudo yum install wget -y
#sudo yum install unzip -y
#sudo yum install dos2unix -y
#sudo yum install telnet -y
#sudo yum install man -y
#sudo yum install mysql-server -y
#sudo /etc/init.d/mysqld start

#Set firewall rules
#iptables -F
#iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
#iptables -P INPUT DROP
#iptables -P FORWARD DROP
#iptables -P OUTPUT ACCEPT
#iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#/sbin/service iptables save
#iptables -L -v


#cd /opt

#Download and install softwares
#JDK
#sudo wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.rpm
#chmod +x jdk-7u55-linux-x64.rpm
#rpm -ivh jdk-7u55-linux-x64.rpm

#Install SonarCube
#wget --progress=bar:force --no-cookies --no-check-certificate http://dist.sonar.codehaus.org/sonarqube-4.1.1.zip
#unzip sonarqube-4.1.1.zip

#sudo ln -s /opt/sonarqube-4.1.1/bin/linux-x86-64/sonar.sh /usr/bin/sonar
#sudo cp /vagrant/replacement_files/sonar /etc/init.d/sonar
#sudo chmod 755 /etc/init.d/sonar
#sudo chkconfig --add sonar

#Configure user .bash_profile
#echo export JAVA_HOME=\"/usr/java/jdk1.7.0_13/\" >> $HOME/.bashrc
#PATH=$JBOSS_HOME/bin:$PATH

#source $HOME/.bashrc

#sudo cp -f /vagrant/replacement_files/sonar.properties /opt/sonarqube-4.1.1/conf
#sudo mysql < /vagrant/scripts/sonar.sql

#Install Jenkins
#sudo wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
#sudo java -jar jenkins.war &

#/etc/init.d/sonar start
