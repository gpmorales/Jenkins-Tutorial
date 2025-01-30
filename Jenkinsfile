pipeline {
    environment {
        DOCKER_HOST = "tcp://172.18.0.3:2375"
        DOCKER_TLS_VERIFY=0
        DOCKER_CERT_PATH=""
        DOCKER_TLS_CERTDIR=""
    }
    agent { 
        docker {
            image 'demisto/python3:3.12.8.1983910'
        }
    }
    triggers {
        pollSCM('H/5 * * * *')
    }
    stages {
        stage('Build') {
            steps {
                echo "Executing Build Stage in New Container."
                sh "echo 'Build Python application...'"
                sh "python3 ./test.py"
            }
        }
        stage('Test') {
            steps {
                echo "Executing Testing Stage in New Container."
                sh "echo 'Running unit tests...'"
            }
        }
        stage('Deploy') {
            steps {
                echo "Executing Deploy Stage in New Container."
                sh "echo 'Preparing to send Docker Images to ECS via AWS CLI..'"
            }
        }
    }
}