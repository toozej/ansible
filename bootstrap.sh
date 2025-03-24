#!/bin/bash -

# help/usage information
function usage {
    echo "Usage: bootstrap.sh [-c] [-r] PLAYBOOK [-d] [-t] [TAGS]"
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
    echo "  -t                  Only run specific tags."
    echo ""
    echo "  TAGS                List of tags to run."
    echo ""
    echo "  -d                  Run Ansible Playbook ouputting to a debug textfile."
    echo ""
}

function set_defaults {
    CHECK=false
    RUN=false
    DEBUG=false
    ANSIBLE_REPO_DIR=/tmp/ansible
    TAGS=false
}

# set defaults before getting user input
set_defaults

# get user input
while getopts ":hc:d:r:s:t:" option
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
    s)
      SKIP_TAGS=true
      ;;
    t)
      TAGS=true
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
    apt-get install -y lsb-release git python3-pip python3-apt dirmngr ansible ansible-lint

# if Fedora
elif [ -f /etc/fedora-release ]; then
    os=$(cat /etc/fedora-release)
    dnf install -y git ansible python3-ansible-lint python3-dnf

# if RedHat-based (but not Fedora)
elif [ -f /etc/redhat-release ]; then
    os=$(cat /etc/redhat-release)
    dnf install -y git ansible

# if MacOS-based
elif [ "$(uname)" == "Darwin" ]; then
    os="mac"
    # set ANSIBLE_REPO_DIR within home directory since MacOS cleans /tmp too quickly
    ANSIBLE_REPO_DIR=~/tmp/ansible
    # install homebrew to install ansible with
    command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    command -v ansible || brew install python3 ansible

# otherwise...
else
    os="$(uname -s) $(uname -r)"
fi

echo "Detected OS: ${os}"

# download and configure ansible on localhost
# trash ANSIBLE_REPO_DIR if it already exists
if  [ -d $ANSIBLE_REPO_DIR ]; then
	echo -e "pre-existing $ANSIBLE_REPO_DIR directory found, removing it before pulling down fresh from Github"
	rm -rf $ANSIBLE_REPO_DIR
fi
echo -e "pulling down ansible repo from github"
git clone https://github.com/toozej/ansible.git $ANSIBLE_REPO_DIR
cd $ANSIBLE_REPO_DIR || exit

echo -e "setting up default ansible.cfg"
cp ansible.cfg.example ansible.cfg

echo -e "setting up localhost in the ansible inventory\n"
if [ "$(uname)" != "Darwin" ]; then
    mkdir /etc/ansible
    echo "localhost ansible_connection=local ansible_python_interpreter=python3" >> /etc/ansible/hosts
fi

# check if github SSH key is configured, and if it's not request user to place it there
if [[ "${os}" == "mac" && ! -f /Users/${SUDO_USER}/.ssh/id_ed25519_github ]]; then
  echo "Github SSH key is not in the correct path, some Ansible roles / playbooks may not function correctly until the key is present"
elif [[ ! -f /home/${SUDO_USER}/.ssh/id_ed25519_github ]]; then
  echo "Github SSH key is not in the correct path, some Ansible roles / playbooks may not function correctly until the key is present"
fi

# if github key is configured, run ansible playbook
echo -e "running ansible playbook based on user input\n"
ANSIBLE_FULL_COMMAND="ansible-playbook"
ANSIBLE_PLAYBOOK_PATH="${ANSIBLE_REPO_DIR}/playbooks/${2}"
RUN_ARG="| tee /tmp/bootstrap.log"
CHECK_ARG="--check"
DEBUG_ARG="-vvv"
DEBUG_OUTPUT_ARG="| tee ${ANSIBLE_REPO_DIR}/playbook_check.out"
TAGS_ARG="--tags \"${4}\""
SKIP_TAGS_ARG="--skip-tags \"${4}\""

# ansible-playbook options
if [[ ${CHECK} == "true" ]]; then
    ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${CHECK_ARG}"
fi
if [[ ${DEBUG} == "true" ]]; then
    ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${DEBUG_ARG}"
fi

# ansible-playbook path
ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${ANSIBLE_PLAYBOOK_PATH}"

# ansible-playbook args
if [[ ${TAGS} == "true" ]]; then
    ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${TAGS_ARG}"
elif [[ ${SKIP_TAGS} == "true" ]]; then
    ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${SKIP_TAGS_ARG}"
fi

# output redirection
if [[ ${DEBUG} == "true" ]]; then
    ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${DEBUG_OUTPUT_ARG}"
elif [[ ${RUN} == "true" ]]; then
    ANSIBLE_FULL_COMMAND="${ANSIBLE_FULL_COMMAND} ${RUN_ARG}"
fi

# actually run ansible-playbook
ANSIBLE_OUTPUT=$("${ANSIBLE_FULL_COMMAND}")

echo -e "\n\n"
if [[ $ANSIBLE_OUTPUT == 0 ]]; then
  echo "all finished bootstrapping"
else
  echo "ansible failed, output: $ANSIBLE_OUTPUT"
fi
