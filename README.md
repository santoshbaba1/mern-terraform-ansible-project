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
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── ansible/
│   ├── inventory.ini
│   ├── web.yml
│   ├── db.yml
│   └── templates/
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

### Step 2

Initialize Terraform

```bash
terraform init
```

### Step 3

Validate Configuration

```bash
terraform validate
```

### Step 4

Review Infrastructure Plan

```bash
terraform plan
```

### Step 5

Deploy Infrastructure

```bash
terraform apply -auto-approve
```

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

### Step 10

Verify Application

Open:

```text
http://<web-server-public-ip>
```

---

## Security Measures Implemented

### Infrastructure Security

- Private subnet for MongoDB
- Restricted SSH access
- Security Group Rules
- IAM Roles with Least Privilege
- NAT Gateway for private resources

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

### Version Control

- Git
- GitHub

---

## Author

Name: Santhosh Sharma

Project:
MERN Application Deployment on AWS using Terraform and Ansible

---

## Repository Link

GitHub Repository:

https://github.com/<your-github-username>/<repository-name>

