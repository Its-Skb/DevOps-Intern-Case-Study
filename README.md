DevOps Case Study

Required Tech Stack

1. Python
2. Flask
3. Docker
4. Terraform
5. Github Actions
6. Ubuntu WSL
7. Bash + Cron

___________________________________________________________________________________________________________________________________________________________________

Task 1: Containerize the Application

Goal: Dockerize the app and import it on port 5000.

Files:
app.py (Flask app), 
Dockerfile (Docker build instructions), 
requirements.txt (Python dependencies)

Docker Commands:  

    docker build -t flask-app .
    docker run -d -p 5000:5000 flask-app

Visit "http://localhost:5000" access the application.

Note - "http://localhost:5000" this will return a message:

    Hello from your Dockerized Flask App!

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Task 2: Setup a CI/CD Pipeline

Goal is to create a GitHub Actions pipeline to: 
Build the Docker image, push the image to a container registry (DockerHub or any private registry), deploy the container on a VM using a simple script.

Workflow File:
              
    .github/workflows/docker-deploy.yml

DockerHub Repository:

https://hub.docker.com/r/saurabhkr24/flask-app

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Task 3: Basic Infrastructure as Code (IaC) with Terraform 

Goal: 

Write a basic Terraform script to launch a virtual machine (VM), open security group ports to allow HTTP and SSH traffic and configure the VM to pull and run the Docker container. 

Setup:

Terraform project created in 

    terraform-local-vm/

Uses "kreuzwerker/docker" provider

Key Resources:

docker_image – pulls Docker image from DockerHub

docker_container – runs app on port 5000

Commands:

    terraform init
    terraform apply
Access the app again via: http://localhost:5000
To destroy the app:
    
    terraform destroy
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Task 4: Basic Application Monitoring and Alerts

Goal is to set up monitoring to track application logs and system performance and also to create a basic alert to notify the team if CPU usage exceeds 70%.

Tools:

1> Bash script: 

    cpu_monitor.sh

2> Cron job: runs every minute

Script Output:

Logs saved in "~/cpu_alerts.log"

Test - Used stress to simulate CPU spike:

    stress --cpu 8 --timeout 120
___________________________________________________________________________________________________________________________________________________________________

Optional Bonus Task:

1. Add a rollback mechanism in the CI/CD pipeline.
2. Implement auto-scaling for containers if resource usage spikes.

Docker images tagged with latest and ${{ github.sha }}, in case of failure, pull the previous SHA version:

    docker run -d -p 5000:5000 saurabhkr24/flask-app:2279513afe1ab1515a8658dcc93a9d08599b680d
Script:

    auto_scaler.sh
Checks CPU usage every minute using cron and launches extra container if usage > 70%, removes it when normalized
Example:

    stress --cpu 8 --timeout 120
Triggers:

    docker run -d -p 5001:5000 --name flask-app-scaled saurabhkr24/flask-app:latest
