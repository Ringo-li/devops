#!/bin/bash
BASEDIR=$(pwd)

function ansible_install(){
  tar -xf ansible_v2.9.9_install.tar.gz
  cd ansible_v2.9.9_install
  bash ansible_v2.9.0_install.sh
}
function ftp_install(){
  cd ${BASEDIR}/../sources
  tar -xf media.tar
  rpm -i media/vsftpd-3.0.2-10.el7.x86_64.rpm 
  cp -r media /var/ftp/pub/
  systemctl start vsftpd
  # systemctl enable vsftpd
}
function package_install(){
  mkdir /etc/yum.repos.d/bak && mv /etc/yum.repos.d/*.repo  /etc/yum.repos.d/bak
  cat ftp.repo > /etc/yum.repos.d/ftp.repo
#   cat>>/etc/yum.repos.d/ftp.repo<<EOF
# [ftp]
# name=ftp
# baseurl=ftp://ansible/pub/media/
# gpgcheck=0
# enabled=1
# EOF
  yum clean all && yum makecache
  yum -y install vim
}

function hosts config(){
  cat hosts.txt > ../auto_install/roles/base/templates/hosts.txt
}
function main(){
  ansible_install
  ftp_install
  package_install
  hosts config
}

main