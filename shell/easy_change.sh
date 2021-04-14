#!/bin/bash
set -e
HOMEDIR=$(pwd)

#SOURCEIP=192.168.193.51
#DIRECTIP=localhost.com
#SOURCEIP=localhost.com
#DIRECTIP=192.168.193.51


SOURCEIP=192.168.193.252
DIRECTIP=localhost.com


# 1.收集配置文件
findfile(){
  echo "扫描config文件..."
  find /mnt/hgfs/DATA/DG1.5/bin/  -name "*config*" -type f > ${HOMEDIR}/config_file.txt
  echo "扫描xml文件..."
  find /mnt/hgfs/DATA/DG1.5/bin/  -name "*xml" -type f  >> ${HOMEDIR}/config_file.txt
  grep -v '\$' ${HOMEDIR}/config_file.txt > ${HOMEDIR}/config_file.txt.bak
  mv ${HOMEDIR}/config_file.txt.bak  ${HOMEDIR}/config_file.txt
}

# 2.修改配置文件中的ip
chage_ip(){
  echo "开始替换IP..."
#  if [ -f "${HOMEDIR}/ip_change_result.txt" ];then
#    rm "${HOMEDIR}/ip_change_result.txt"
#  else
#    touch "${HOMEDIR}/ip_change_result.txt"
#  fi
  time=$(date "+%Y-%m-%d %H:%M:%S")
  echo "---------------${time}-------------------" >> ${HOMEDIR}/ip_change_result.txt
  OLDIFS=$IFS
  IFS=$'\n'

  for i in $(cat ${HOMEDIR}/config_file.txt);do
    filename=\"${i}\"
    result=$(eval sed -n '/${SOURCEIP}/s/${SOURCEIP}/${DIRECTIP}/p' "${filename}" )
    if [ ! -z "${result}" ];then
      eval sed -i '/${SOURCEIP}/s/${SOURCEIP}/${DIRECTIP}/' "${filename}"
      echo "${filename}替换成功"
      echo ${filename} >> ${HOMEDIR}/ip_change_result.txt
    fi
  done
  IFS=$OLDIFS

    echo "替换完成，修改文件列表保存在ip_change_result.txt"

}

findfile
chage_ip
