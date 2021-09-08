#!/bin/bash
#注意：parted每一个操作会立刻生效，数据无价，注意保护。

#查看GPT格式磁盘的信息
parted /dev/sda print

# 将多余磁盘标记为主分区
parted -s /dev/sda  "mkpart primary   10.5GB   30G"

#查看GPT格式磁盘的信息
parted /dev/sda print
# 用mkfs.ext4将/dev/sda1格式化为ext4文件系统格式
mkfs.ext4 /dev/sda3
mkdir -p /data
#将磁盘分区加入到/etc/fstab文件
echo "/dev/sda3 /data   ext4    defaults        0 0" >> /etc/fstab
mount -a

# 用dd命令创建一个8G的文件（8G=1024*1024*8=8388608）
# dd if=/dev/sda of=/var/swapfile bs=1024 count=8388608
parted -s /dev/sda  "mkpart primary   30GB   -1"
# 将它创建为Linux Swap虚拟交换文件
mkswap /dev/sda4
echo "/dev/sda4 swap                    swap    defaults        0 0" >> /etc/fstab
swapon -a