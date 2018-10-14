pipeline {
  agent none
  stages {
    stage('Setup Pre-reqs (14.04)') {
      agent {
        docker {
          image 'ubuntu:14.04'
        }

      }
      steps {
        sh '''# update apt and ensure pip is latest version
sudo apt-get update -qq
sudo apt-get install python-pip -y
sudo pip install --upgrade --force pip

# combat not having CA Certs installed
sudo pip install pyopenssl ndg-httpsclient urllib3 pyasn1 requests

# setup the james user
sudo useradd -m -c "james" james -s /bin/bash'''
      }
    }
    stage('Install Ansible (14.04)') {
      agent {
        docker {
          image 'ubuntu:14.04'
        }

      }
      steps {
        sh '''ANSIBLE_VERSION=latest
if [ "$ANSIBLE_VERSION" = "latest" ]; then pip install ansible; else pip install ansible==$ANSIBLE_VERSION; fi
if [ "$ANSIBLE_VERSION" = "latest" ]; then pip install ansible-lint; fi
'''
      }
    }
    stage('Check Test (14.04)') {
      agent {
        docker {
          image 'ubuntu:14.04'
        }

      }
      steps {
        sh '''# Check the role/playbook\'s syntax.
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
      }
    }
    stage('Run Test (14.04)') {
      agent {
        docker {
          image 'ubuntu:14.04'
        }

      }
      steps {
        sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id
'''
      }
    }
  }
}