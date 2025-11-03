# Project 1 - JENKINS-DOCKER
***Jenkins-Docker***


_**Overview**_

Objective: Automate build, test, and deployment of a sample application using Jenkins, Docker, AWS ECR, and ECS Fargate. Skills Demonstrated: CI/CD, Docker, AWS (ECR, ECS Fargate), GitHub integration, automation scripting.


_**Architecture Diagram**_

GitHub Repo --> Jenkins Pipeline --> Docker Build --> ECR Repository  --> ECS Fargate Task --> Public App Endpoint
* Jenkins automatically triggers on GitHub push via webhook.
* Docker image is built and pushed to AWS ECR.
* ECS Fargate pulls the image and runs the container.
* App is publicly accessible on assigned port.


_**Tools & Services Used**_

* Jenkins – CI/CD automation server
* Docker – Containerization of the app
* GitHub – Source control and webhook trigger
* AWS ECR – Docker image registry
* AWS ECS Fargate – Serverless container deployment
* AWS CLI – Command-line operations for AWS resources


_**Pipeline Stages**_

* Stage 1 – Checkout Code: Pull code from GitHub repository using SSH key.
* Stage 2 – Build Docker Image: Build Docker container from Dockerfile.
* Stage 3 – Push to AWS ECR: Authenticate and push Docker image.
* Stage 4 – Deploy to ECS Fargate: ECS Task Definition configured and service started.
*  Stage 5 – Test: Verify app is reachable and serving correct content.


_**Key Implementation Steps**_

1.	EC2 Setup: Launch Jenkins EC2 instance (t3.micro, free tier), installed Jenkins and Docker, configured security groups.
2.	Jenkins Setup: Installed Git, Pipeline, Docker plugins; configured pipeline to connect to GitHub via SSH.
3.	GitHub Integration: Added SSH key, configured webhook to trigger Jenkins pipeline.
4.	Docker & ECS: Dockerfile created, image built by Jenkins, pushed to ECR, deployed via Fargate.
5.	Testing: Pipeline build verification and app accessibility checks.


_**Challenges & Solutions**_

Challenge	 -  Solution
* Permission denied for Docker socket  - 	Ran Jenkins as user in Docker group and used sudo.
* GitHub access issues  - 	Used SSH method. SSH key added to GitHub and Jenkins credentials.
* Webhook not triggering  -	 Corrected webhook URL and Jenkins GitHub plugin configuration.
* Build failing in Jenkins  -	 Verified Dockerfile syntax, environment variables, and user permissions.


_**Output / Screenshots**_

•	Jenkins Pipeline 

  Console Output:

  <img width="1920" height="1080" alt="Capture1" src="https://github.com/user-attachments/assets/e02a2f0f-b77d-4249-bcf2-70b6fe1ba9c8" />

  Pipeline Overview:

  <img width="1920" height="1080" alt="8" src="https://github.com/user-attachments/assets/5c4c5bb5-95c5-430e-80b8-4f2ad1b41eb8" />

  Pipeline Output:

  <img width="1920" height="1080" alt="Jenkins1" src="https://github.com/user-attachments/assets/cc8f7929-ca7f-43e5-9958-edc2d70fb259" />


•	Docker image listed in ECR

  <img width="1920" height="1080" alt="6" src="https://github.com/user-attachments/assets/87a67347-8ea7-4649-b891-17ad0225221c" />


•	ECS Fargate running task

  <img width="1920" height="1080" alt="5" src="https://github.com/user-attachments/assets/ee8edda3-4c46-4b45-83d1-19dd7290004d" />


•	App running in browser 

  First Output:

  <img width="1920" height="1080" alt="7" src="https://github.com/user-attachments/assets/4efc9b77-0139-4e31-8c9c-1a1a2d504971" />

  Output got through CI/CD Pipeline after pushing an update to github repo:

  <img width="1920" height="1080" alt="1" src="https://github.com/user-attachments/assets/7b638081-dfcc-4373-b90b-c369ec91e064" />



