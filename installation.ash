#!/bin/ash
#
# startscript: normaly run it only once
# (c) 2015/2016 sosyco@googlemail.com  www.sosyco.de
# 
# enhance the repositories and update the system
if ! [ -f "/etc/apk/repositories.org" ]; 
then 
  cp /etc/apk/repositories /etc/apk/repositories.$(date "+%Y%m%d-%H:%M:%S")
  sed -ni 'p; s/\/main/\/community/p' /etc/apk/repositories
fi
apk update
apk upgrade
apk add git sudo docker
getent passwd dockeradmin > /dev/null 2&>1
if ! [ $? -eq 0 ]; 
then 
  ssh-keygen -f dockeradmin -t rsa -b 4096 -C dockeradmin -N ''
  adduser -D dockeradmin
  mkdir -p /home/dockeradmin/.ssh/
  cp dockeradmin.pub /home/dockeradmin/.ssh/authorized_keys
  chmod 700 -R /home/dockeradmin/.ssh 
  chown dockeradmin.dockeradmin -R /home/dockeradmin/.ssh
  echo "dockeradmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
  adduser dockeradmin docker
fi
sed -i "s/DOCKER_OPTS.*/DOCKER_OPTS=\"--bip=192.168.199.1\/24\"/" /etc/conf.d/docker
echo "don't forget to save the private sshkey: dockeardmin"

