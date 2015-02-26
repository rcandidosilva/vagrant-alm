#!/bin/sh
#Install Oracle JDK
cd /opt

echo "Downloading Oracle JDK..."
wget -nv --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.tar.gz"
echo "Oracle JDK downloaded."
sudo tar xzf /opt/jdk-8u31-linux-x64.tar.gz
sudo rm jdk-8u31-linux-x64.tar.gz
cd /opt/jdk1.8.0_31/

sudo alternatives --install /usr/bin/java java /opt/jdk1.8.0_31/bin/java 2
sudo alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_31/bin/jar 2
sudo alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_31/bin/javac 2
sudo alternatives --set java /opt/jdk1.8.0_31/bin/java
sudo alternatives --set jar /opt/jdk1.8.0_31/bin/jar
sudo alternatives --set javac /opt/jdk1.8.0_31/bin/javac

export JAVA_HOME=/opt/jdk1.8.0_31
export JRE_HOME=/opt/jdk1.8.0_31/jre
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
echo "Oracle JDK installed."
