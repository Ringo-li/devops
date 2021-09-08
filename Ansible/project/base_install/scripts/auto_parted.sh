#!/bin/bash
#注意：parted每一个操作会立刻生效，数据无价，注意保护。
#判断是否存在/data目录
if [ -d "/data" ];then
  echo "/data目录已经存在"
  exit 1
fi
#将磁盘标记成GPT格式
parted -s /dev/sdb mklabel gpt

#查看GPT格式磁盘的信息
parted /dev/sdb print

# 将0%到100%的磁盘标记为主分区
parted -s /dev/sdb "mkpart extend 0% 100%"

#查看GPT格式磁盘的信息
parted /dev/sdb print
# 用mkfs.ext4将/dev/sdb1格式化为ext4文件系统格式
mkfs.ext4 /dev/sdb1

#创建挂载目录，在根目录下创建data文件夹
mkdir /data

#将磁盘分区/dev/sdb1加入到/etc/fstab文件
echo "/dev/sdb1 /data   ext4    defaults        0 0" >> /etc/fstab

#挂载
mount -a
