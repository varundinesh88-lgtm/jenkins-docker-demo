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
                    sh 'docker rm -f jenkins-demo-app || true'
                    sh 'docker run -d --name jenkins-demo-app -p 8081:8080 jenkins-demo-app'
                }
            }
        }

        stage('Test Container') {
            steps {
                script {
                    echo "🧪 Testing application endpoint..."
                    sh 'sleep 5'
                    sh '''
                    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8081)
                    if [ "$STATUS" -ne 200 ]; then
                      echo "❌ Test failed! Application not responding correctly."
                      exit 1
                    else
                      echo "✅ Test passed! Application is healthy."
                    fi
                    '''
                }
            }
        }
    }
}
