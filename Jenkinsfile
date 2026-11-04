pipeline {
  agent none
  stages {
    stage('Validate') {
      parallel {
        stage('Debian 13') {
          agent {
            dockerfile {
              filename 'dockerfiles/Dockerfile_debian_stable'
            }
          }
          steps {
            sh 'yamllint --strict .'
            sh 'ansible-lint --strict'
            sh 'python3 tests/validate.py'
          }
        }
        stage('Fedora stable') {
          agent {
            dockerfile {
              filename 'dockerfiles/Dockerfile_fedora_latest'
            }
          }
          steps {
            sh 'python3 tests/validate.py'
          }
        }
      }
    }
  }
}
