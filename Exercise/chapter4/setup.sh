#/bin/sh
echo exclude=centos-release* >> /etc/yum.conf
echo exclude=kernel* >> /etc/yum.conf
mv /etc/yum.repos.d/*.repo /root
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache
yum install -y yum-utils git vim gcc glibc-static telnet bridge-utils net-tools
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum install -y yum install docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
docker version
sed -i /PasswordAuthentication/s/no/yes/ /etc/ssh/sshd_config
systemctl  restart sshd