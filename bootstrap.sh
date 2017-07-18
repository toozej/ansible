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
echo "determining OS and distro, then installing python2 git and ansible packages\n"
if [ -f /etc/lsb-release ]; then
        os=$(lsb_release -s -d)

# if Debian-based
elif [ -f /etc/debian_version ]; then
        os="Debian $(cat /etc/debian_version)"
        apt-get update
        apt-get install -y git python-apt
        echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
        apt-get update
        apt-get install ansible

## if RedHat-based
elif [ -f /etc/redhat-release ]; then
        os=`cat /etc/redhat-release`
        yum update
        if [[ $os == *"release 7."* ]]; then
          epel_rpm="https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
          yum install -y python-dnf
        elif [[ $os == *"release 6."* ]]; then
          epel_rpm="https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm"
        fi
        yum install -y $epel_rpm
        yum install -y git python2 ansible

# if ArchLinux-based
elif [ -f /etc/arch-release ]; then
        os="archlinux"
        pacman -S ansible git python2

## otherwise...
else
        os="$(uname -s) $(uname -r)"
fi

echo "\n\n"
echo "setting up ansible\n"
echo "setting up localhost in the ansible inventory\n"
echo "localhost ansible_connection=local" >> /etc/ansible/hosts

echo "pulling down ansible repo from github\n"
git clone https://github.com/toozej/ansible.git /tmp/ansible
cd /tmp/ansible
echo "\n\n"

echo "running ansible playbook based on user input\n"

# get user input
while getopts "h" option
do
  case $option in
    h)
      usage
      exit 1
      ;;
    ?)
      usage
      exit 1
      ;;
  esac
done


# parse user input
# run the ansible playbooks based on the playbook names inserted by user


echo "\n\n"
echo "all finished bootstrapping"

