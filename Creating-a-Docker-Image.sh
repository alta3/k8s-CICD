#!/usr/bin/bash
cd ~
sudo usermod -aG docker $USER
sleep 5
mkdir ~/downloads/
sleep 5
cd ~/downloads/
wget https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
cd ~
mkdir -p ~/go/src/github.com/alta3/hello
mkdir -p ~/go/bin
sudo tar -C /usr/local -vxzf ~/downloads/go1.11.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export GOBIN=~/go/bin
export PATH=$PATH:~/go/bin
cd ~/go/src/github.com/
mv ~/.ssh/config ~/.ssh/config.old
git clone https://github.com/alta3/webby.git
cd webby/
export GO111MODULE="on"
go mod init
go get -u github.com/stripe/stripe-go/v72
go get .
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o webserver .
sudo docker build -t webby -f ~/git/k8s-CICD/k8s-docker/scratch .
sudo docker run -d -p 2345:5000 registry:2
sudo cp ~/git/k8s-CICD/k8s-config/bchd.registry_hosts /etc/hosts
sudo cp ~/git/k8s-CICD/k8s-config/bchd-reg /etc/nginx/sites-enabled/reg
sudo nginx -s reload
sudo docker tag webby bchd.registry/webby
sleep 60
sudo docker push bchd.registry/webby
