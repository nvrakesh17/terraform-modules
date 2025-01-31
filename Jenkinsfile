pipeline {
    agent any

    stages {
        stage('Terraform Plan') {
            steps {
                sh './terraform_wrapper.sh plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh './terraform_wrapper.sh apply'
            }
        }
    }
}
