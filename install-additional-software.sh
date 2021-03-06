#!/usr/bin/env bash

# vs-code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /dev/null
sudo apt-get update > /dev/null
sudo apt-get -yqq install code > /dev/null

# docker
curl -fsSL https://get.docker.com | sh

# docker-compose
DOCKER_COMPOSE_VERSION=$(curl -s "https://api.github.com/repos/docker/compose/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/"$DOCKER_COMPOSE_VERSION"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# kubectl
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO "https://storage.googleapis.com/kubernetes-release/release/"$KUBECTL_VERSION"/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# kubectx, kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# k9s
K9S_LATEST_VERSION=$(curl -s "https://api.github.com/repos/derailed/k9s/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
curl -LO https://github.com/derailed/k9s/releases/download/$K9S_LATEST_VERSION/k9s_"$(uname -s)"_"$(uname -p)".tar.gz
tar -xvf k9s_"$(uname -s)"_"$(uname -p)".tar.gz
chmod +x ./k9s
sudo mv ./k9s /usr/local/bin/k9s
rm LICENSE README.md k9s_"$(uname -s)"_"$(uname -p)".tar.gz
 
# helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# az cli
curl -L https://aka.ms/InstallAzureCli | bash

# istio
ISTIO_LATEST_VERSION=$(curl -s "https://api.github.com/repos/istio/istio/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

curl -L https://istio.io/downloadIstio | ISTIO_VERSION="$ISTIO_LATEST_VERSION" sh -
sudo mv istio-"$ISTIO_LATEST_VERSION"/bin/istioctl /usr/local/bin/istioctl
rm -rf istio-"$ISTIO_LATEST_VERSION"
