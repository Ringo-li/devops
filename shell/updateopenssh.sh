yum install  -y gcc gcc-c++ glibc make autoconf openssl openssl-devel pcre-devel  pam-deve pam* zlib*
mv /usr/bin/openssl /usr/bin/openssl_bak
mv /usr/include/openssl /usr/include/openssl_bak
cd /usr/local/src
mv /root/openss* /usr/local/src	

tar -xzf openssl-1.1.1k.tar.gz && cd openssl-1.1.1k && ./config --prefix=/usr/local/openssl --shared && make && make install
ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/openssl/include/openssl /usr/include/openssl
`echo "/usr/local/openssl/lib" >>/etc/ld.so.conf`
ln -s /usr/local/lib64/libssl.so.1.1 /usr/lib64/libssl.so.1.1
ln -s /usr/local/lib64/libcrypto.so.1.1 /usr/lib64/libcrypto.so.1.1
ldconfig -v
openssl version




cd /etc/ssh && mkdir –p /root/sshbak && mv ./* /root/sshbak
cd /usr/local/src
tar zxvf openssh-8.6p1.tar.gz
cd openssh-8.6p1
./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-openssl-includes=/usr/local/openssl/include --with-ssl-dir=/usr/local/openssl --with-zlib --with-md5-passwords --with-pam
make && make install
mv /usr/bin/ssh /usr/bin/ssh-bak2021
ln -s /usr/local/openssh/bin/ssh /usr/bin/ssh
cp -a contrib/redhat/sshd.init /etc/init.d/sshd
cp -a contrib/redhat/sshd.pam /etc/pam.d/sshd.pam
chmod +x /etc/init.d/sshd
chkconfig --add sshd && systemctl enable sshd
mv  /usr/lib/systemd/system/sshd.service  /usr/local/src
mv  /usr/lib/systemd/system/sshd-keygen.service /usr/local/src
mv  /usr/lib/systemd/system/sshd.socket /usr/local/src
sed -i "s#SSHD=/usr/sbin/sshd#SSHD=/usr/local/openssh/sbin/sshd#g" /etc/init.d/sshd
mv /usr/bin/ssh-add /usr/bin/ssh-add.bak
mv /usr/bin/ssh-agent /usr/bin/ssh-agent.bak
mv /usr/bin/ssh-keygen /usr/bin/ssh-keygen.bak
mv /usr/bin/ssh-keyscan /usr/bin/ssh-keyscan.bak

ln -s /usr/local/openssh/bin/ssh-add /usr/bin/ssh-add
ln -s /usr/local/openssh/bin/ssh-agent /usr/bin/ssh-agent
ln -s /usr/local/openssh/bin/ssh-keyscan /usr/bin/ssh-keyscan
ln -s /usr/local/openssh/bin/ssh-keygen /usr/bin/ssh-keygen




mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat > /etc/ssh/sshd_config <<"EOF"
Protocol 2
SyslogFacility AUTHPRIV
PermitRootLogin yes #这个是允许root登陆
PasswordAuthentication yes
ChallengeResponseAuthentication no
#UsePAM yes  #这个需要注释不然我这里发现会root无法登陆密码对了也不行
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
X11Forwarding yes
#配置sshd交换算法
KexAlgorithms diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group-exchange-sha256,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group1-sha1
EOF

chkconfig sshd on
systemctl restart sshd && systemctl status sshd
ssh -V