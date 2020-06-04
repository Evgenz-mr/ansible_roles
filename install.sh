#!/bin/bash

## ansible release

## Default variables to use
export IP=${IP:="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"}
export API_PORT=${API_PORT:="8443"}

# install update
yum update -y

# install the following base packages
yum install -y curl wget git zile nano net-tools docker-1.13.1 \
                python-cryptography python2-pip python-devel  python-passlib \

# install epel
yum -y install epel-release

# install the Ansible
yum install ansible
ssh-keygen -t rsa
service sshd restart
ssh-copy-id -i ~/.ssh/id_rsa.pub $IP

# configure Ansible
git clone https://github.com/Evgenz-mr/ansible_roles.git
cd ansible_roles
ansible-playbook site_installation.yml