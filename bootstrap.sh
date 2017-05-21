#!/bin/bash - 
#===============================================================================
#
#          FILE: bootstrap.sh
# 
#         USAGE: ./bootstrap.sh 
# 
#   DESCRIPTION: bootstrap new OS install using Ansible
# 
#       OPTIONS: ---
#        AUTHOR: toozej
#       CREATED: 05/20/2017 17:14
#===============================================================================

fn_distro(){
arch=$(uname -m)
kernel=$(uname -r)
if [ -f /etc/lsb-release ]; then
        os=$(lsb_release -s -d)
elif [ -f /etc/debian_version ]; then
        os="Debian $(cat /etc/debian_version)"
elif [ -f /etc/redhat-release ]; then
        os=`cat /etc/redhat-release`
else
        os="$(uname -s) $(uname -r)"
fi
}

