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
        stage('Build') {
            steps {
                sh 'docker build -t my-apache-image .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run -d -p 8080:80 my-apache-image'
            }
        }
    }
}
