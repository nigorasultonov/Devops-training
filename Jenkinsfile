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
                git 'https://github.com/nigorasultonov/Devops-training.git'
            }
        }
         stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-apache-image .'
        stage('Docker Run') {
            steps {
                sh 'docker run -d -p 8080:80 my-apache-image'
            }
        }
    }
}
