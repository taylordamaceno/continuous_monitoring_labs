#!/bin/bash
#install basic packages
sudo gpasswd -a vagrant docker 
sudo gpasswd -a vagrant root 
sudo echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo apt-get install net-tools -y
sudo apt-get install curl -y
sudo apt-get install telnet -y 
sudo apt-get install bind-utils -y 
sudo apt-get install net-tools -y 
sudo apt get install curl -y 
sudo apt-get install bash-completion


# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker vagrant

# installl docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# install  k8s
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
chmod +x ./kind

#install go
sudo apt install go
# install  kubectl
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# START DOCKER
sudo service docker start 
sudo usermod -aG docker $USER
newgrp docker

