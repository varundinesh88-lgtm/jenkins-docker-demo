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
                    echo "Cleaning up old containers and images..."
                    sh '''
                    docker rm -f jenkins-demo-app || true
                    docker rmi -f jenkins-demo-app || true
                    '''
                    
                    echo "Building new Docker image..."
                    sh 'docker build -t jenkins-demo-app .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo "Starting container on port 8081..."
                    sh 'docker run -d --name jenkins-demo-app -p 8081:8080 jenkins-demo-app'
                }
            }
        }

        stage('Post-Build Info') {
            steps {
                script {
                    sh 'docker ps'
                    echo "Access your app at: http://<EC2_PUBLIC_IP>:8081"
                }
            }
        }
    }
}

