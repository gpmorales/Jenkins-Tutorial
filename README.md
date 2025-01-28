# Jenkins Pipeline Tutorial: A Generic CI/CD Project Example

In this tutorial, the CI/CD logic is **centralized into one repository** (e.g., `example-ci-cd`) to manage the build, test, and deployment workflows for multiple codebases (e.g., backend and frontend) in a single place.

This approach eliminates the need for Jenkinsfiles in each repository, ensuring consistency, simplicity, and ease of maintenance.

---

## **Repository Architecture**

### **Repositories in the Project**

1. **Backend Repository (`example-backend`)**:

   - Contains only the backend source code and dependencies.
   - No CI/CD logic (e.g., no Jenkinsfile in this repo).

2. **Frontend Repository (`example-frontend`)**:

   - Contains only the frontend source code and dependencies.
   - No CI/CD logic (e.g., no Jenkinsfile in this repo).

3. **CI/CD Repository (`example-ci-cd`)**:
   - Manages all Jenkins pipeline definitions, shared scripts, and environment-specific configurations for both backend and frontend.

NOTE: Separate Jenkinsfiles for Backend and Frontend
This will manage backend and frontend pipelines independently and still trigger them together when needed, and use separate Jenkinsfiles for the backend and frontend services.

---

## **Pipeline Breakdown**

### **Stages**

1. **Clone**: Fetch the backend and frontend repositories from Git.
2. **Build**: Build the backend and frontend code.
3. **Test**: Run unit and integration tests for each service.
4. **Package**: Create deployable artifacts (e.g., Docker images).
5. **Deploy**: Deploy artifacts to staging, production, or other environments.

---

## **Centralized Jenkinsfile**

This **Jenkinsfile** resides in the `example-ci-cd` repository and handles pipelines for both backend and frontend.

````groovy
pipeline {
    agent any
    stages {
        stage('Clone Backend') {
            steps {
                git url: 'https://github.com/example-org/example-backend.git', branch: 'main'
            }
        }
        stage('Build Backend') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Test Backend') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Package Backend') {
            steps {
                sh 'docker build -t example-backend ./example-backend'
            }
        }
        stage('Deploy Backend') {
            steps {
                sh './scripts/deploy-backend.sh'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}


```groovy
pipeline {
    agent any
    stages {
        stage('Clone Frontend') {
            steps {
                git url: 'https://github.com/example-org/example-frontend.git', branch: 'main'
            }
        }
        stage('Build Frontend') {
            steps {
                sh 'npm install && npm run build'
            }
        }
        stage('Test Frontend') {
            steps {
                sh 'npm test'
            }
        }
        stage('Package Frontend') {
            steps {
                sh 'docker build -t example-frontend ./example-frontend'
            }
        }
        stage('Deploy Frontend') {
            steps {
                sh './scripts/deploy-frontend.sh'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}


```groovy
pipeline {
    agent any
    stages {
        stage('Trigger Backend Pipeline') {
            steps {
                build job: 'backend-pipeline-job', wait: false
            }
        }
        stage('Trigger Frontend Pipeline') {
            steps {
                build job: 'frontend-pipeline-job', wait: false
            }
        }
    }
}


ci-cd-repo/
├── orchestrator/
│   └── Jenkinsfile-orchestrator  # Master orchestrator pipeline
├── backend/
│   └── Jenkinsfile-backend       # Pipeline for the backend
├── frontend/
│   └── Jenkinsfile-frontend      # Pipeline for the frontend
├── scripts/
│   ├── deploy-backend.sh         # Deployment script for backend
│   ├── deploy-frontend.sh        # Deployment script for frontend
│   └── shared.sh                 # Shared functions for both pipelines
└── README.md                     # Documentation for CI/CD
````
