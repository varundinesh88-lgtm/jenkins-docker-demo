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
                    def dockerImage = docker.build("jenkins-demo-app")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh "docker run -d -p 8081:8080 jenkins-demo-app"
                }
            }
        }
    }
}

