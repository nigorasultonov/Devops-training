pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker pull hello-world'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run hello-world'
            }
        }
        stage('Pull Dockerfile') {
            steps {
                git url: 'https://github.com/nigorasultonov/Devops-training.git', branch: 'main'
                sh 'git checkout Dockerfile'
            }
        }
         stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-apache-image .'
            }
         }
        stage('Docker Run') {
            steps {
                sh 'docker run -d -p 8080:80 my-apache-image'
            }
         }
    }
    post {
        always {
            // Cleanup steps that should always run, regardless of pipeline result
            cleanUpContainers()
        }
    }
}

def cleanUpContainers() {
    // Stop and remove Docker containers
    sh 'docker stop $(docker ps -a -q)'
    sh 'docker rm $(docker ps -a -q)'
}
