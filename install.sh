#!/bin/bash

## ansible release
# git clone --single-branch https://github.com/Evgenz-mr/ansible_roles.git --branch ver1.0

## VARIABELS
# for git
GIT=https://github.com/Evgenz-mr/ansible_roles.git
BRANCH=ver1.0

# for ip list
IP_LIST=/tmp/list

# for ssh copy
SSH_PUB_KEY=~/.ssh/id_rsa.pub
USER=root
HOST=192.168.88.228
PASSWD=root

# install update
yum update -y

# install the following base packages
yum install -y curl wget git nano net-tools docker-1.13.1 \
                python-cryptography python2-pip python-devel  python-passlib \

# install epel
yum -y install epel-release

### copy passwd ssh IP_LIST###
#if [ ! -f $IP_LIST ]
#then
#    echo "=======STARTING COPY SSH ID========"
#    for ip in `cat $IP_LIST`; do
#    sshpass -p "$PASSWD" ssh-copy-id -o StrictHostKeyChecking=no $USER@$ip
#done
### --------------- ###

### copy passwd ssh 1 server
ssh-keygen -t rsa
service sshd restart
sshpass -p "$PASSWD" ssh-copy-id -o StrictHostKeyChecking=no $USER@$HOST

# install the Ansible
yum install ansible

# configure Ansible
git clone --single-branch $GIT --branch $BRANCH
ansible-playbook ansible_roles/site_installation.yml