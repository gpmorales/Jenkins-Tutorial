pipeline {
    agent { 
        node {
            label 'docker-python-agent'
            reuseNode true
        }
    }
    triggers {
        pollSCM('H/5 * * * *')
    }
    stages {
        stage('Build') {
            steps {
                echo "Executing Build stage."
                sh "echo 'Build Python application...'"
                sh "python3 ./test.py"
            }
        }
        stage('Test') {
            steps {
                echo "Executing Testing stage."s
                sh "echo 'Running unit tests...'"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Executing Deploy Stage.'
                sh "echo 'Preparing to send Docker Images to ECS via AWS CLI..'"
            }
        }
    }
}