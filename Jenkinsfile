pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = 'jenkins-demo-app'
        AWS_ACCOUNT_ID = '829730167210'
        IMAGE_NAME = 'jenkins-demo-app'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'git@github.com:varundinesh88-lgtm/jenkins-docker-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
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

        stage('Push to ECR') {
            steps {
                script {
                    echo "🔐 Logging in to AWS ECR..."
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                    docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest
                    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO:latest
                    '''
                }
            }
        }
    }
}
