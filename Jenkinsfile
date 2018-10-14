pipeline {
  agent none
  stages {
    stage('Check Test (14.04)') {
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
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml --syntax-check'''
      }
    }
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
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i tests/inventory tests/test.yml -vv --skip-tags github,copy_host_ssh_id
'''
      }
    }
  }
}