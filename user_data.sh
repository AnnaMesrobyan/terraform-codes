#!/bin/bash

sudo apt update -y
sudo apt install apache2 -y


sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install python3.8 -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt update -y
sudo apt install ansible -y

sudo apt-get update -y
sudo apt-get install fontconfig openjdk-17-jre -y


sudo systemctl start apache2
sudo systemctl enable apache2
