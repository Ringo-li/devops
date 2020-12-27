#/bin/sh
sudo echo exclude=kernel* >> /etc/yum.conf
sudo echo exclude=centos-release* >> /etc/yum.conf
sudo yum install -y yum-utils git vim gcc glibc-static telnet bridge-utils net-tools
sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker
sudo systemctl start docker
#sudo usermod -aG dockerroot vagrant
sudo systemctl restart docker
docker version
sudo sed -i /PasswordAuthentication/s/no/yes/ /etc/ssh/sshd_config
sudo systemctl  restart sshd