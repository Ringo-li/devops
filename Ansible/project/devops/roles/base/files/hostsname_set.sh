#!/bin/bash
ip=$(ip a | grep inet|grep -v 127.0.0.1|grep -v inet6| grep -v dynamic |  awk '{print$2}' | grep -v 172.| awk -F/ '{print$1}')
localname=$(cat /etc/hosts |  grep ${ip} | awk '{print $2}')
hostnamectl set-hostname ${localname}
