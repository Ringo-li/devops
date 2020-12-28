#/bin/sh

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0
systemctl disable firewalld
systemctl stop firewalld

# install some tools
#mv /etc/yum.repos.d/*.repo /root
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#yum makecache
yum install -y perl dkms kernel-devel kernel-headers make bzip2
yum install -y yum-utils git vim gcc glibc-static telnet bridge-utils net-tools wget


# install docker
#yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
#国内源
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum -y install docker-ce-19.03.1-3.el7 docker-ce-cli-19.03.1-3.el7 containerd.io

# open password auth for backup if ssh key doesn't work, bydefault, username=vagrant password=vagrant
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

#sudo setenforce 0
#
## install kubeadm, kubectl, and kubelet.
##国内的源
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

#Node节点不需要按照kubectl
yum -y install kubelet kubeadm kubectl


sudo bash -c 'cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward=1
EOF'
sudo sysctl --system

