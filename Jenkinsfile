pipeline {
    agent { 
        docker {
            image 'devopsjourney1/myjenkinsagents:python'
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