#!/bin/bash
echo "#############################开始安装Ansible依赖内容#####################################"
rpm -ivh Ansible_install_RPM/* --nodeps --force
echo "#############################开始安装Ansible#############################################"
rpm -ivh ansible-2.9.9-1.el7.ans.noarch.rpm
echo "#############################安装Ansible完成#############################################"
cp ansible.cfg /etc/ansible/ <<EOF
y
EOF
echo "#############################Ansible调优完成#############################################"
ansible --version
