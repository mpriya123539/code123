#!/bin/bash -eux
sudo yum update -y
sudo yum install wget unzip -y
sudo wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
sudo unzip ./terraform_0.13.5_linux_amd64.zip -d /usr/local/bin/
sudo dnf update  -y
sudo dnf install git  -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo yum install -y python3 libffi
sudo  yum install -y gcc libffi-devel  openssl-devel
sudo yum install perl-core zlib-devel -y
cd /usr/local/src/
sudo echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
sudo yum install azure-cli -y
/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync

sudo mkdir -p /.ssh
eval ssh-agent
echo "#{sshkey}#" >> /.ssh/authorized_keys

sudo yum install -y yum-utils
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
sudo curl -4fsSL https://download.docker.com/linux/centos/gpg | sudo apt-key add -
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-nightly
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo yum update -y
sudo yum -y install httpd mod_ssl
sudo dnf install dotnet-sdk-5.0  -y
sudo dnf install aspnetcore-runtime-5.0  -y
sudo dnf install dotnet-runtime-5.0  -y
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum install -y kubectl
