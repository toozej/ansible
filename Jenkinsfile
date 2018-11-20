pipeline {
  agent none
  stages {
    stage('Syntax Check') {
      parallel {
        stage('Syntax Check (14.04)') {
          agent {
            dockerfile {
              filename 'Dockerfile_ubuntu_1404'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Check the role/playbook\'s syntax.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
          }
        }
        stage('Syntax Check (18.04)') {
          agent {
            dockerfile {
              filename 'Dockerfile_ubuntu_1804'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Check the role/playbook\'s syntax.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
          }
        }
        stage('Syntax Check (Debian Stable)') {
          agent {
            dockerfile {
              filename 'Dockerfile_debian_stable'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Check the role/playbook\'s syntax.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
          }
        }
        stage('Syntax Check (Debian Testing)') {
          agent {
            dockerfile {
              filename 'Dockerfile_debian_testing'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Check the role/playbook\'s syntax.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
          }
        }
        stage('Syntax Check (Fedora Latest)') {
          agent {
            dockerfile {
              filename 'Dockerfile_fedora_latest'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Check the role/playbook\'s syntax.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
          }
        }
        stage('Syntax Check (CentOS 7)') {
          agent {
            dockerfile {
              filename 'Dockerfile_centos_7'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Check the role/playbook\'s syntax.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
          }
        }
      }
    }
    stage('Run Tests') {
      parallel {
        stage('Run Test (14.04)') {
          agent {
            dockerfile {
              filename 'Dockerfile_ubuntu_1404'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id
'''
          }
        }
        stage('Run Test (18.04)') {
          agent {
            dockerfile {
              filename 'Dockerfile_ubuntu_1804'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id'''
          }
        }
        stage('Run Test (Debian Stable)') {
          agent {
            dockerfile {
              filename 'Dockerfile_debian_stable'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id'''
          }
        }
        stage('Run Test (Debian Testing)') {
          agent {
            dockerfile {
              filename 'Dockerfile_debian_testing'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id'''
          }
        }
        stage('Run Test (Fedora Latest)') {
          agent {
            dockerfile {
              filename 'Dockerfile_fedora_latest'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id'''
          }
        }
        stage('Run Test (CentOS 7)') {
          agent {
            dockerfile {
              filename 'Dockerfile_centos_7'
            }

          }
          environment {
            ANSIBLE_VERSION = 'latest'
          }
          steps {
            sh '''# Run the role/playbook with ansible-playbook.
ANSIBLE_ROLES_PATH=roles ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id'''
          }
        }
      }
    }
  }
}
