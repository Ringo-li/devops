local_ip=$(ip a |  grep 192.168 |  cut -b 10-23)
#####一、基本配置#####
#1）关闭SElinux和Firewalld服务；
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0
systemctl disable firewalld
systemctl stop firewalld
#2）设置hostname并在/etc/hosts配置本地解析；
echo "${local_ip} master1.lab.com" >>  /etc/hosts
#3）关闭Swap服务
swapoff -a
sed -i '/swap/d' /etc/fstab
#4）修改sysctl.conf
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.conf
sysctl -p
#若提示cannot stat /proc/sys/net/bridge/bridge-nf-call-ip6tables: No such file or directory
#modprobe net_brfilter
#sysctl -p

#####二、所有节点安装Docker服务#####

#1) 如果已安装过旧版本需要删除：
#yum -y remove docker-client docker-client-latest docker-common docker-latest docker-logrotate docker-latest-logrotate \ docker-selinux docker-engine-selinux docker-engine
#2) 设置阿里云docker仓库，并安装Docker服务；
#yum -y install yum-utils lvm2 device-mapper-persistent-data nfs-utils xfsprogs wget
#yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
#yum -y install docker-ce docker-ce-cli containerd.io
#systemctl enable docker
#systemctl start docker

#####三、所有节点安装K8S服务#####

#1) 如果已安装过旧版本，需要删除：
#yum -y remove kubelet kubadm kubctl
#2) 设置阿里云的仓库,并安装新版本
#cat <<EOF > /etc/yum.repos.d/kubernetes.repo
#[kubernetes]
#name=Kubernetes
#baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
#enabled=1
#gpgcheck=0
#repo_gpgcheck=0
#gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
#EOF

#Node节点不需要按照kubectl
#yum -y install kubelet kubeadm kubectl


#3) 修改Docker Cgroup Driver为systemd，如果不修改则在后续添加Worker节点时可能会遇到“detected cgroupfs as ths Docker driver.xx”的报错信息，并配置Docker本地镜像库；
cat > /etc/docker/daemon.json <<EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {
    "max-size": "100m"
    },
    "storage-driver": "overlay2",
    "registry-mirrors":[
        "https://kfwkfulq.mirror.aliyuncs.com",
        "https://2lqq34jg.mirror.aliyuncs.com",
        "https://pee6w651.mirror.aliyuncs.com",
        "http://hub-mirror.c.163.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://registry.docker-cn.com"
    ]
}
EOF

#4) 重启Docker，并启动Kubelet
systemctl daemon-reload
systemctl restart docker
systemctl enable kubelet
systemctl start kubelet


#####四、Master节点部署#####

#1) 如果需要初始化Master节点，请执行#kubeadm reset;
#2) 配置环境变量：
echo export MASTER_IP=192.168.33.150 > k8s.env.sh
echo export APISERVER_NAME=master1.lab.com >> k8s.env.sh
sh k8s.env.sh
#3) Master节点初始化
kubeadm init \
        --apiserver-advertise-address 192.168.33.150 \
        --apiserver-bind-port 6443 \
        --cert-dir /etc/kubernetes/pki \
        --control-plane-endpoint master1.lab.com \
        --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers \
        --pod-network-cidr 10.11.0.0/16 \
        --service-cidr 10.20.0.0/16 \
        --service-dns-domain cluster.local \
        --upload-certs


#####五、安装Calico网络插件#####
#集群必须安装网络插件以实现Pod间通信，只需要在Master节点操作，其他Node节点会自动创建相关Pod；
wget https://docs.projectcalico.org/v3.8/manifests/calico.yaml
#该配置文件默认采用的Pod的IP地址为192.168.0.0/16，需要修改为集群初始化参数中采用的值，本例中为10.10.0.0/16；
sed -i "s#192\.168\.0\.0/#10\.10\.0\.0/16#" calico.yaml
kubectl apply -f calico.yaml
#1) 等待所有容器状态处于Running状态：
watch -n 2 kubectl get pods -n kube-system -o wide
kubectl get nodes -o wide #查看所有node状态
#2) 获取join命令参数，并保存输出结果：
kubeadm token create --print-join-command > node.join.sh