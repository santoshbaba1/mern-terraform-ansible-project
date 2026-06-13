# MERN Application Deployment on AWS using Terraform and Ansible

## Project Title

TravelMemory MERN Application Deployment on AWS using Infrastructure as Code (Terraform) and Configuration Management (Ansible)

---

## Project Overview

This project demonstrates the deployment of a full-stack MERN (MongoDB, Express.js, React.js, Node.js) application on Amazon Web Services (AWS) using:

- Terraform for Infrastructure Provisioning
- Ansible for Server Configuration and Application Deployment
- AWS EC2, VPC, Subnets, Internet Gateway, NAT Gateway, Security Groups, and IAM
- MongoDB Database Server
- Node.js Backend Server
- React Frontend Application
- NGINX Reverse Proxy

The deployed application is based on the TravelMemory project.

Repository Used:

:contentReference[oaicite:0]{index=0}

---

## Objectives

- Automate AWS infrastructure provisioning using Terraform.
- Configure application and database servers using Ansible.
- Deploy a production-ready MERN application.
- Implement security best practices.
- Demonstrate Infrastructure as Code (IaC) and Configuration Management.

---

## Architecture

```text
                   Internet
                       │
               Internet Gateway
                       │
               Public Subnet
                       │
             Web Server EC2 Instance
        React Frontend + Express Backend
                       │
                   NAT Gateway
                       │
               Private Subnet
                       │
             MongoDB EC2 Instance
```

---

## AWS Infrastructure Components

### Networking

- Custom VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- NAT Gateway
- Route Tables

### Compute

- Web Server EC2 Instance
- Database Server EC2 Instance

### Security

- Security Groups
- IAM Roles
- SSH Key Pair

---

## Project Structure

```text
project/
│
├── terraform/
│   ├── providers.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── ansible/
│   ├── inventory.ini
│   ├── web.yml
│   ├── db.yml
│   └── dbuser.yml
│   └── env.yml
│   └── nginx-ssl.yml
│
├── travel-memory/
│   ├── backend
│   ├── frontend
│
├── screenshots/
│
├── architecture/
│   └── architecture-diagram.png
│
└── README.md
```

---

## Terraform Implementation

### Resources Created

### VPC

- CIDR Block: 10.0.0.0/16

### Public Subnet

- CIDR Block: 10.0.1.0/24

### Private Subnet

- CIDR Block: 10.0.2.0/24

### Internet Gateway

Provides internet access to the public subnet.

### NAT Gateway

Provides outbound internet access to the private subnet.

### Route Tables

Configured for:
- Public Traffic
- Private Traffic

### EC2 Instances

#### Web Server

- Ubuntu Server
- Public IP Enabled
- Node.js
- React Application

#### Database Server

- Ubuntu Server
- Private Network Only
- MongoDB Database

### Security Groups

#### Web Security Group

Allowed Ports:

| Port | Purpose |
|--------|----------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 3000 | React |
| 5000 | Backend API |

#### Database Security Group

Allowed Ports:

| Port | Purpose |
|--------|----------|
| 27017 | MongoDB |
| 22 | SSH via Bastion |

---

## Ansible Implementation

### Web Server Configuration

Tasks performed:

- Install Git
- Install Curl
- Install Node.js
- Install NPM
- Clone TravelMemory Repository
- Install Backend Dependencies
- Install Frontend Dependencies
- Configure Environment Variables
- Configure NGINX
- Start Application

### Database Server Configuration

Tasks performed:

- Install MongoDB
- Configure MongoDB Service
- Create Database
- Create Application User
- Enable Authentication
- Configure Firewall

---

## Deployment Process

### Step 1

Configure AWS CLI

```bash
aws configure
```
 - <img width="1347" height="409" alt="awscli 5" src="https://github.com/user-attachments/assets/15ce4c10-4f3e-4843-94f0-7c7b23a35efd" />


### Step 2

Initialize Terraform

```bash
terraform init
```
 - <img width="1364" height="722" alt="terr init" src="https://github.com/user-attachments/assets/577d52c5-e0f8-43e3-a9b7-40dd74d42f50" />

 - <img width="1887" height="878" alt="tera init" src="https://github.com/user-attachments/assets/e4cba286-9728-474f-bdeb-1fc46d0272fd" />

### Step 3

Validate Configuration

```bash
terraform validate
```
 - <img width="1362" height="727" alt="terr valitae" src="https://github.com/user-attachments/assets/89f78b59-9e5b-4dfe-a7db-a161eead91d3" />

 - <img width="1892" height="166" alt="tera vali" src="https://github.com/user-attachments/assets/8d03cead-a63d-4d53-b3b8-5c6fb5d8089e" />


### Step 4

Review Infrastructure Plan

```bash
terraform plan
```
 - <img width="1365" height="723" alt="terr plan" src="https://github.com/user-attachments/assets/42d63045-e2b8-4f07-8016-1d3962d45680" />

 
- <img width="1892" height="701" alt="tera app-1" src="https://github.com/user-attachments/assets/fa11ddef-63c7-4e16-9add-97e9a557d262" />


### Step 5

Deploy Infrastructure

```bash
terraform apply -auto-approve
```
 - <img width="1364" height="721" alt="terra depl" src="https://github.com/user-attachments/assets/144f8359-6b1b-404d-89cc-c2414733efa5" />


### Step 6

Verify EC2 Instances

```bash
aws ec2 describe-instances
```

### Step 7

Configure Ansible Inventory

Update:

```ini
inventory.ini
```

with generated EC2 IP addresses.

### Step 8

Run Database Configuration

```bash
ansible-playbook -i inventory.ini db.yml
```


### Step 9

Run Web Server Configuration

```bash
ansible-playbook -i inventory.ini web.yml
```
 - <img width="1345" height="718" alt="ans web 1" src="https://github.com/user-attachments/assets/2368fcf5-1aee-4c2c-b6b6-a9830c2b0828" />

 - <img width="1348" height="717" alt="ngix 1" src="https://github.com/user-attachments/assets/d0fb3123-a701-4d3b-85a1-55142c93e7fe" />


### Step 10

Verify Application

Open:

```text
https://graphtech.live, https://www.graphtech.live
```

---

## Security Measures Implemented

### Infrastructure Security

- Private subnet for MongoDB
- Restricted SSH access
- Security Group Rules
- IAM Roles with Least Privilege
- NAT Gateway for private resources
 - <img width="1309" height="629" alt="iam permission" src="https://github.com/user-attachments/assets/8a178ecd-a299-4391-a1e3-86c0b6cbb7e7" />



### Server Hardening

- Disabled Root Login
- Disabled Password Authentication
- SSH Key Authentication Only
- UFW Firewall Configuration
- MongoDB Authentication Enabled

### Database Security

- MongoDB User Authentication
- Private Network Access
- Restricted Security Group Access

---

## Application Components

### Frontend

Technology:

- React.js

Responsibilities:

- User Interface
- API Communication
- User Interaction

### Backend

Technology:

- Node.js
- Express.js

Responsibilities:

- REST API
- Authentication
- Database Operations

### Database

Technology:

- MongoDB

Responsibilities:

- Data Storage
- Application Records
- User Information

---

## Component Interaction Flow

```text
User
 │
 ▼
React Frontend
 │
 ▼
Express Backend API
 │
 ▼
MongoDB Database
```

---

## Verification Commands

### Check MongoDB

```bash
sudo systemctl status mongod
```

### Check Node.js

```bash
node -v
```

### Check NPM

```bash
npm -v
```

### Check NGINX

```bash
sudo systemctl status nginx
```

### Check Running Processes

```bash
pm2 list
```

---

## Screenshots Included

The following screenshots are included in the repository:

1. Terraform Apply Success
2. AWS VPC Dashboard
3. AWS EC2 Instances
4. Security Groups
5. Terraform Outputs
6. Ansible Playbook Execution
7. MongoDB Service Status
8. Node.js Application Running
9. React Frontend Homepage
10. Final Working Application

---

## Challenges Faced

- VPC Networking Configuration
- NAT Gateway Setup
- MongoDB Connectivity Between Subnets
- React and Express Integration
- Security Group Configuration
- Environment Variable Management

---

## Future Enhancements

- Docker Containerization
- Docker Compose Deployment
- Jenkins CI/CD Pipeline
- AWS ECR Integration
- AWS EKS Deployment
- HTTPS using ACM and Load Balancer
- Monitoring using Prometheus and Grafana
- Logging using ELK Stack

---

## Technologies Used

### Cloud

- AWS EC2
- AWS VPC
- AWS IAM
- AWS Security Groups
- AWS NAT Gateway
- AWS Internet Gateway

### Infrastructure

- Terraform

### Configuration Management

- Ansible

### Backend

- Node.js
- Express.js

### Frontend

- React.js

### Database

- MongoDB

### Web Server

- NGINX
- 

### Version Control

- Git
- GitHub

---

## Author

Sanhosh Kumar Sharma

Project:
MERN Application Deployment on AWS using Terraform and Ansible

---

## Repository Link

GitHub Repository:

https://github.com/<your-github-username>/<repository-name>

