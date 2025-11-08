pipeline {
    agent any

    environment {
        IMAGE_NAME = "jenkins-demo-app"
        AWS_REGION = "us-east-1"
        ECR_REPO = "829730167210.dkr.ecr.us-east-1.amazonaws.com/jenkins-demo-app"
        CLUSTER_NAME = "jenkins-demo-cluster"
        SERVICE_NAME = "jenkins-demo-service"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/varundinesh88-lgtm/Jenkins-Docker-CI.CD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Container for Testing') {
            steps {
                script {
                    sh '''
                    echo "Cleaning up old containers..."
                    docker rm -f jenkins-demo-app || true

                    echo "Starting new test container..."
                    docker run -d --name jenkins-demo-app -p 8081:8080 ${IMAGE_NAME}
                    '''
                }
            }
        }

        stage('Test Application') {
            steps {
                script {
                    sh '''
                    echo "Testing app endpoint..."
                    sleep 5
                    curl -I http://localhost:8081 || exit 1
                    '''
                }
            }
        }

        stage('Login to AWS ECR') {
            steps {
                script {
                    sh '''
                    echo "Logging in to AWS ECR..."
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Tag and Push Docker Image to ECR') {
            steps {
                script {
                    sh '''
                    echo "Tagging and pushing image..."
                    docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                    '''
                }
            }
        }

        stage('Deploy to ECS Fargate') {
            steps {
                script {
                    sh """
                    echo "Triggering ECS service update..."
                    aws ecs update-service \
                        --cluster $CLUSTER_NAME \
                        --service $SERVICE_NAME \
                        --force-new-deployment \
                        --region $AWS_REGION
                    """
                }
            }
        }
    }

    post {
        always {
            sh '''
            echo "Cleaning up test container..."
            docker rm -f jenkins-demo-app || true
            '''
        }
    }
}
