#!/bin/bash
#注意：parted每一个操作会立刻生效，数据无价，注意保护。

#网络设置
# echo "" > /etc/resolv.conf
# ip link set dev enp0s3 down

#查看GPT格式磁盘的信息
parted /dev/sda print

# 将多余磁盘标记为主分区
parted -s /dev/sda  "mkpart primary   10.5GB   -1"

#查看GPT格式磁盘的信息
parted /dev/sda print
# 用mkfs.ext4将/dev/sda1格式化为ext4文件系统格式
mkfs.ext4 /dev/sda3
mkdir -p /var/ftp/pub/
#将磁盘分区加入到/etc/fstab文件
echo "/dev/sda3 /var/ftp/pub/   ext4    defaults        0 0" >> /etc/fstab
mount -a
