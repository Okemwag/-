def role = 'frontend'
def environment = 'dev'
def inventoryBasePath = './ansible/inventory'
def sitePath = './ansible/site-deploy.yml'
def inventoryPath = "${inventoryBasePath}/${environment}/${role}.yml"
def revision = null

pipeline {
  agent any

  options {
    ansiColor('xterm')
    timeout(time: 30, unit: 'MINUTES')
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  environment {
    ANSIBLE_FORCE_COLOR = '1'
    ANSIBLE_HOST_KEY_CHECKING = 'False'
  }

  parameters {
    string(
      defaultValue: 'development',
      description: 'Git branch to build the application from',
      name: 'revision',
      trim: true
    )
    booleanParam(
      defaultValue: false,
      description: 'Skip deployment and only run validation',
      name: 'validateOnly'
    )
  }

  stages {
    stage('Init') {
      steps {
        script {
          if (params.revision && params.revision != '') { 
            revision = params.revision 
            echo "Building from revision: ${revision}"
          } else { 
            error('Parameter revision can not be null/empty; Aborting build...')
          }
        }
      }
    }

    stage('Validate Inventory') {
      steps {
        script {
          if (!fileExists(inventoryPath)) {
            error("Inventory file not found at ${inventoryPath}")
          }
          if (!fileExists(sitePath)) {
            error("Playbook file not found at ${sitePath}")
          }
        }
      }
    }

    stage('Deploy via Ansible') {
      when {
        expression { return !params.validateOnly }
      }
      steps {
        ansiblePlaybook(
          inventory: inventoryPath,
          playbook: sitePath,
          colorized: true,
          disableHostKeyChecking: true,
          extras: "-e revision=${revision} -e environment=${environment}"
        )
      }
    }
  }

  post {
    always {
      script {
        currentBuild.description = "Revision: ${revision}"
      }
    }
    success {
      echo "Deployment completed successfully!"
    }
    failure {
      echo "Deployment failed. Check the logs for details."
    }
    cleanup {
      cleanWs()
    }
  }
}
