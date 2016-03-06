#!/bin/ash
#
# startscript: normaly run it only once
# (c) 2015/2016 sosyco@googlemail.com  www.sosyco.de
# 
# enhance the repositories and update the system
cp /etc/apk/repositories /etc/apk/repositories.$(date "+%Y%m%d-%H:%M:%S")
sed -ni 'p; s/\/main/\/community/p' /etc/apk/repositories
apk update
apk upgrade
apk add git ansible sudo docker
ssh-keygen -f files/dockeradmin -t rsa -b 4096 -C dockeradmin -N ''
useradd -D dockeradmin
mkdir -p /home/dockeradmin/.ssh/
cp files/dockeradmin.pub /home/dockeradmin/.ssh/authorized_keys
chmod 664 -R /home/dockeradmin/.ssh 
chown dockeradmin.dockeradin -R /home/dockeradmin/.ssh
