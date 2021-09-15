kubeadm init \
   --apiserver-advertise-address={{ k8s_master_ip }} \
   --image-repository {{ local_images }} \
   --kubernetes-version v1.20.0 \
   --service-cidr=10.96.0.0/12 \
   --pod-network-cidr=10.244.0.0/16 \
   --ignore-preflight-errors=all