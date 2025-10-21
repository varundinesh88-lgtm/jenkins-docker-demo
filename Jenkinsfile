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
                    // Build the Docker image
                    def dockerImage = docker.build("jenkins-demo-app")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop and remove any existing container first
                    sh "docker rm -f jenkins-demo-app || true"
                    
                    // Run the container in detached mode with a port that matches security group
                    sh "docker run -d --name jenkins-demo-app -p 8081:8080 jenkins-demo-app python3 -m http.server 8080"
                }
            }
        }
    }
}

