#!/bin/bash
set -ex
BASEDIR=$(pwd)

function package_install(){
  #开始配置yum
  cd ${BASEDIR}
  mkdir /etc/yum.repos.d/bak && mv /etc/yum.repos.d/*.repo  /etc/yum.repos.d/bak
  sed -i "/changeme/s%changeme%${BASEDIR}%" postgis.repo
  cat postgis.repo > /etc/yum.repos.d/postgis.repo
  yum clean all && yum makecache
  #开始安装软件包
  yum install -y postgis2_96 
  rm -rf /etc/yum.repos.d/postgis.repo
  mv /etc/yum.repos.d/bak/*.repo  /etc/yum.repos.d/
  rm -rf /etc/yum.repos.d/bak/
}

function main(){
    tar -xf postgis.tar
    package_install
    rm -rf ${BASEDIR}/postgis
}

main
