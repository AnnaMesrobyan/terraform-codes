#!/bin/bash
sudo apt update 
sudo apt install apache2 -y 
sudo apt install openjdk-11-jdk -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update 
sudo apt install jenkins -y
sudo systemctl status jenkins
sudo apt install jq -y
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
sudo apt update
sudo apt install docker.io -y
docker --version
sudo chmod 666 /var/run/docker.sock #you can use this trick if in jennkins you will see "permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock:"
sudo apt update
