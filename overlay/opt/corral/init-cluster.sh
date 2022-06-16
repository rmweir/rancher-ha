#!/bin/bash

# Configure k3s
mkdir -p /etc/rancher/k3s
cat > /etc/rancher/k3s/config.yaml <<- EOF
cluster-init: true
tls-san:
  - "${CORRAL_kube_api_host}"
no-deploy:
  - local-storage
  - metrics-server
EOF

# install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.21.7+k3s1 sh -

sed -i "s/127.0.0.1/${CORRAL_kube_api_host}/g" /etc/rancher/k3s/k3s.yaml

mkdir ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
