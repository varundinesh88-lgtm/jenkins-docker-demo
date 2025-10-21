pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'git@github.com:varundinesh88-lgtm/jenkins-docker-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("jenkins-demo-app")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    dockerImage.run('-d -p 8080:8080')
                }
            }
        }
    }
}
