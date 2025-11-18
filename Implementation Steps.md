# Jenkins-Docker-CI/CD Testing Guide

________________________________________

## 1. Prerequisites

### Local/Server Requirements

•	EC2 Instance (Ubuntu)
  o	Minimum 2 vCPUs and 4GB RAM (m7i-flex.large or t3.medium+ recommended)
  o	Docker installed and running
  o	Jenkins installed and running
  o	AWS CLI installed
  o	Git installed
•	Security Group allowing:
  o	SSH (port 22)
  o	HTTP (port 8080) for Jenkins
  o	Optional: Ports 80/443 if your app needs it
•	IAM Role or AWS credentials with permissions:
  o	AmazonEC2ContainerRegistryFullAccess
  o	AmazonECS_FullAccess
  o	IAMReadOnlyAccess (for ECS task execution roles)

GitHub Requirements

•	Repository containing:
  o	Dockerfile for your application
  o	Jenkinsfile for CI/CD pipeline

•	GitHub branch (e.g., main) to build from

________________________________________

2. EC2 / Jenkins Setup Commands

Update & Install Docker

sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

Log out and log back in to apply Docker group permissions.

Install Jenkins

sudo apt update
sudo apt install -y openjdk-17-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

Install AWS CLI

sudo apt install -y awscli
aws configure

# Enter your Access Key, Secret Key, default region (us-east-1), output format (json)

Verify Docker and Jenkins

docker run hello-world

sudo systemctl status jenkins

Access Jenkins

http://<EC2-Public-IP>:8080

________________________________________

3. Prepare GitHub Repository

Ensure repo structure:

Jenkins-Docker-CI.CD/
  ├─ Dockerfile
  ├─ Jenkinsfile
  └─ <app files>

Verify Jenkinsfile environment variables:

•	IMAGE_NAME → Name of your Docker image
•	AWS_REGION → e.g., us-east-1
•	ECR_REPO → Full ECR repository URI

________________________________________

4. Jenkins Pipeline Setup

  1.	Create a new Jenkins job
    o	Select Pipeline → Pipeline script from SCM
    o	SCM: Git → GitHub repo URL
    o	Branch: main
    o	Script Path: Jenkinsfile
  2.	Install required plugins
    o	Docker Pipeline
    o	AWS Steps / AWS Credentials
  3.	Add AWS credentials
    o	aws-creds (access key + secret key)

________________________________________

5. Pipeline Execution Steps

  1.	Trigger build manually or via GitHub webhook

  2.	Pipeline stages:

    o	Clone repository
    o	Build Docker image
    o	Run Docker container for testing
    o	Test application endpoint
    o	Login to AWS ECR
    o	Tag & push Docker image
    o	Deploy to ECS Fargate

________________________________________

6. Verify Deployment

  Check Jenkins logs

    docker ps        # Optional: check test container

  Check ECS service

    aws ecs describe-services --cluster jenkins-demo-cluster --services jenkins-demo-service

  Access your app

    http://<ECS-Service-Public-IP>:8080

________________________________________

7. Cleanup (Optional)

# Stop Jenkins container if running
  docker rm -f jenkins-demo-app || true

# Delete ECS service & cluster

  aws ecs update-service --cluster jenkins-demo-cluster --service jenkins-demo-service --desired-count 0
  aws ecs delete-service --cluster jenkins-demo-cluster --service jenkins-demo-service
  aws ecs delete-cluster --cluster jenkins-demo-cluster

# Delete ECR image

  aws ecr batch-delete-image --repository-name jenkins-demo-app --image-ids imageTag=latest

________________________________________

