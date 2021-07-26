#!/bin/bash

set -e

if [ -L "/usr/java/default/jdk1.8.0_101" ];then
	echo "installed"
	exit 0
fi
wget ftp://ansible/pub/data/packages/jdk1.8.0_101.tar.gz  -P /opt/ 
tar -xf /opt/jdk1.8.0_101.tar.gz -C /opt
chmod +x /opt/jdk1.8.0_101/bin/*
chmod +x /opt/jdk1.8.0_101/jre/bin/*
mkdir -p /usr/java
ln -s /opt/jdk1.8.0_101 /usr/java/default


cat>>/etc/profile<<"EOF"
export JAVA_HOME=/opt/jdk1.8.0_101
export classpath=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
EOF

source /etc/profile