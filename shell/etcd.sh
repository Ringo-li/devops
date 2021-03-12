#!/bin/bash
set -e

for node in {1..3}
do
  #scp -o "StrictHostKeyChecking no" etcd3:/etc/etcd/etcd.conf /etc/etcd/
  #ssh -t -o "StrictHostKeyChecking no" etcd${node} "$(cat <<'EOF' > etcdInstall.sh
  #ssh  -o "StrictHostKeyChecking no" etcd${node}  > /dev/null 2>&1 << EOF
  ssh -t -o "StrictHostKeyChecking no" etcd${node} > /dev/null 2>&1 <<'EOF'
# LOCAL_IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/')
# echo ${LOCAL_IP}
ETCD_NAME=etcd$(cat /etc/hosts |  grep $(hostname) | awk -F"etcd" '{print$2}' | cut -b1)
echo ${ETCD_NAME}
sed -i "/ETCD_NAME=/s/default/${ETCD_NAME}/" /etc/etcd/etcd.conf
sed -i "/ETCD_DATA_DIR=/s/default/${ETCD_NAME}/" /etc/etcd/etcd.conf
sed -i "/ETCD_LISTEN_PEER_URLS=/s/#//" /etc/etcd/etcd.conf
sed -i "/ETCD_LISTEN_PEER_URLS=/s/localhost/${ETCD_NAME}/" /etc/etcd/etcd.conf
sed -i "/ETCD_LISTEN_CLIENT_URLS=/s|http://localhost:2379|http://localhost:2379,http://${ETCD_NAME}:2379|" /etc/etcd/etcd.conf
sed -i "/ETCD_INITIAL_ADVERTISE_PEER_URLS=/s/#//" /etc/etcd/etcd.conf
sed -i "/ETCD_INITIAL_ADVERTISE_PEER_URLS=/s/localhost/${ETCD_NAME}/" /etc/etcd/etcd.conf
sed -i "/ETCD_INITIAL_CLUSTER=/s/#//" /etc/etcd/etcd.conf
sed -i "/ETCD_INITIAL_CLUSTER=/s|default=http://localhost:2380|etcd1=http://etcd1:2380,etcd2=http://etcd2:2380,etcd3=http://etcd3:2380|" /etc/etcd/etcd.conf
sed -i "/ETCD_INITIAL_CLUSTER_STATE=/s/#//" /etc/etcd/etcd.conf
sed -i "/ETCD_INITIAL_CLUSTER_TOKEN=/s/#//" /etc/etcd/etcd.conf
sed -i "/ETCD_ADVERTISE_CLIENT_URLS=/s/localhost/${ETCD_NAME}/" /etc/etcd/etcd.conf
systemctl enable etcd
systemctl restart etcd
exit
EOF

done

etcdctl member list
etcdctl cluster-health
