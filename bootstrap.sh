#!/bin/bash -

# help/usage information
function usage {
    echo "Usage: bootstrap.sh [-c] [-r] PLAYBOOK"
    echo ""
    echo "  -h                  Display usage."
    echo ""
    echo "  -c                  Run Ansible Playbook in check mode."
    echo ""
    echo "  -r                  Run Ansible Playbook."
    echo ""
    echo "  PLAYBOOK            Filename of the Ansible playbook to run."
    echo "                        For example, web-server.yml."
    echo ""
    echo "  -d                  Run Ansible Playbook ouputting to a debug textfile."
    echo ""
}

function set_defaults {
    CHECK=false
    RUN=false
    DEBUG=false
    ANSIBLE_REPO_DIR=/tmp/ansible
}

# set defaults before getting user input
set_defaults

# get user input
while getopts ":hc:d:r:" option
do
  case $option in
    h)
      usage
      exit 1
      ;;
    c)
      CHECK=true
      ;;
    r)
      RUN=true
      ;;
    d)
      DEBUG=true
      ;;
    ?)
      usage
      exit 1
      ;;
  esac
done


echo -e "determining OS and distro, then installing python, git, and ansible packages\n"
# if Debian-based
if [ -f /etc/debian_version ]; then
    os="Debian $(cat /etc/debian_version)"
    apt-get update
    apt-get install -y lsb-release git python3-pip python3-apt dirmngr --install-recommends
    echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main" > /etc/apt/sources.list.d/ansible.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    apt-get update
    apt-get install -y ansible ansible-lint

# if Fedora
elif [ -f /etc/fedora-release ]; then
    os=`cat /etc/fedora-release`
    dnf install -y git ansible python3-ansible-lint python3-dnf

# if RedHat-based (but not Fedora)
elif [ -f /etc/redhat-release ]; then
    os=`cat /etc/redhat-release`
    dnf install -y git ansible

# if MacOS-based
elif [ "$(uname)" == "Darwin" ]; then
    os="mac"
    # set ANSIBLE_REPO_DIR within home directory since MacOS cleans /tmp too quickly
    ANSIBLE_REPO_DIR=~/tmp/ansible

    # for now, still using Python 2.7 for Ansible on MacOS, so force last version of pip that supports Python 2.7
    easy_install pip==20.3.4
    pip install ansible ansible-lint

# otherwise...
else
    os="$(uname -s) $(uname -r)"
fi

# download and configure ansible on localhost
# trash ANSIBLE_REPO_DIR if it already exists
if  [ -d $ANSIBLE_REPO_DIR ]; then
	echo -e "pre-existing $ANSIBLE_REPO_DIR directory found, removing it before pulling down fresh from Github"
	rm -rf $ANSIBLE_REPO_DIR
fi
echo -e "pulling down ansible repo from github"
git clone https://github.com/toozej/ansible.git $ANSIBLE_REPO_DIR
cd $ANSIBLE_REPO_DIR

echo -e "setting up default ansible.cfg"
cp ansible.cfg.example ansible.cfg

echo -e "setting up localhost in the ansible inventory\n"
if [ "$(uname)" == "Darwin" ]; then
    mkdir /etc/ansible
    echo "localhost ansible_connection=local" >> /etc/ansible/hosts
else
    mkdir /etc/ansible
    echo "localhost ansible_connection=local ansible_python_interpreter=python3" >> /etc/ansible/hosts
fi

# check if github SSH key is configured, and if it's not request user to place it there
if [ -z /home/james/.ssh/id_rsa_github ]; then
  echo "Github SSH key is not in the correct path, please add and retry"
  exit 1
fi

# if github key is configured, run ansible playbook
echo -e "running ansible playbook based on user input\n"
if [[ $CHECK == "true" && $DEBUG == "false" ]]; then
  ANSIBLE_OUTPUT=$(ansible-playbook --check $ANSIBLE_REPO_DIR/playbooks/$2)
elif [[ $CHECK == "true" && $DEBUG == "true" ]]; then
  ANSIBLE_OUTPUT=$(ansible-playbook --check $ANSIBLE_REPO_DIR/playbooks/$2 -vvv | tee $ANSIBLE_REPO_DIR/playbook_check.out)
elif [[ $RUN == "true" && $DEBUG == "false" ]]; then
  ANSIBLE_OUTPUT=$(ansible-playbook $ANSIBLE_REPO_DIR/playbooks/$2 | tee /tmp/bootstrap.log)
elif [[ $RUN == "true" && $DEBUG == "true" ]]; then
  ANSIBLE_OUTPUT=$(ansible-playbook $ANSIBLE_REPO_DIR/playbooks/$2 -vvv | tee $ANSIBLE_REPO_DIR/playbook_run.out)
fi

echo -e "\n\n"
if [[ $ANSIBLE_OUTPUT == 0 ]]; then
  echo "all finished bootstrapping"
else
  echo "ansible failed, output: $ANSIBLE_OUTPUT"
fi
