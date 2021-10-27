#!/bin/bash
set -e
#注意：parted每一个操作会立刻生效，数据无价，注意保护。
localname=$(hostname)
if [[ "${localname}" = "docker-registry" ]] || [[ "${localname}" = "gitlab" ]]; then
	#查看GPT格式磁盘的信息
	parted /dev/sda print

	# 将多余磁盘标记为主分区
	parted -s /dev/sda  "mkpart primary   10.5GB   -1"

	#查看GPT格式磁盘的信息
	parted /dev/sda print
	# 用mkfs.ext4将/dev/sda1格式化为ext4文件系统格式
	mkfs.ext4 /dev/sda3
	mkdir -p /data
	#将磁盘分区加入到/etc/fstab文件
	echo "/dev/sda3 /data   ext4    defaults        0 0" >> /etc/fstab
	sleep 10
	mount -a
elif [[ "${localname}" = k8s* ]]; then
	echo "k8s host does not require partition"
elif [[ "${localname}" = "ansible" ]]; then
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
	sleep 10
	mount -a
	#!/bin/bash
else
	echo "This host does not require partition"
fi


