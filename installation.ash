#!/bin/ash
#
# installation of needed packages
# (c) 2015/2016 sosyco@googlemail.com  www.sosyco.de
# 
# 
apk update
apk upgrade
apk add git ansible sudo
ssh-keygen -f dockeradmin -t rsa -b 4096 -C dockeradmin -N ''
