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
<<<<<<< HEAD
                    echo "Cleaning up old containers and images..."
                    sh '''
                    docker rm -f jenkins-demo-app || true
                    docker rmi -f jenkins-demo-app || true
                    '''
                    
                    echo "Building new Docker image..."
                    sh 'docker build -t jenkins-demo-app .'
=======
                    dockerImage = docker.build("jenkins-demo-app")
>>>>>>> 1fdaccf (Added Test stage to Jenkins pipeline)
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
<<<<<<< HEAD
                    echo "Starting container on port 8081..."
=======
                    // Stop any running container with same name
                    sh 'docker rm -f jenkins-demo-app || true'
                    // Run a new one
>>>>>>> 1fdaccf (Added Test stage to Jenkins pipeline)
                    sh 'docker run -d --name jenkins-demo-app -p 8081:8080 jenkins-demo-app'
                }
            }
        }

<<<<<<< HEAD
        stage('Post-Build Info') {
            steps {
                script {
                    sh 'docker ps'
                    echo "Access your app at: http://<EC2_PUBLIC_IP>:8081"
=======
        stage('Test Container') {
            steps {
                script {
                    echo "🧪 Testing application endpoint..."
                    // Wait a few seconds for the app to start
                    sh 'sleep 5'
                    // Test using curl
                    sh '''
                    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8081)
                    if [ "$STATUS" -ne 200 ]; then
                      echo "❌ Test failed! Application not responding correctly."
                      exit 1
                    else
                      echo "✅ Test passed! Application is healthy."
                    fi
                    '''
>>>>>>> 1fdaccf (Added Test stage to Jenkins pipeline)
                }
            }
        }
    }
}
