#!/bin/bash

mkdir -p /var/lib/zookeeper/{data,log}
chown -R zookeeper:zookeeper /var/lib/zookeeper
ip=$(ip a | grep 192.168.33 | awk '{print $2}' | awk -F/ '{print $1}')
myid=$(cat /etc/hosts |  grep ${ip} |grep zookeeper | awk -F"zookeeper0" '{print $2}' |  cut -b 1)
# sudo -u zookeeper zookeeper-server-initialize --myid=${myid} --force
sudo -u zookeeper echo ${myid} > /var/lib/zookeeper/data/myid
