# Digital Ocean DevOps Infrastructure for a React-SpringBoot Application

This repository contains infrastructure provisioning and deployment automation code for React-SpringBoot application in a development environment on Digital Ocean.

## Table of Contents

- [Overview](#overview)
- [Infrastructure](#infrastructure)
- [Configuration](#configuration)
- [CI/CD Pipeline](#cicd-pipeline)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Security Considerations](#security-considerations)

## Overview

This project provides a complete DevOps solution for deploying React-SpringBoot applications on Digital Ocean. It includes:

- Infrastructure as Code (IaC) using Terraform
- Configuration management with Ansible
- Continuous Deployment with Jenkins
- Docker-based application deployment
- Automated SSL certificate management

## Infrastructure

The infrastructure is provisioned in Digital Ocean's Singapore (`sgp1`) region and includes:

- Virtual machines for application hosting
- Networking components
- Security groups and firewall rules
- Load balancers (if required)

### Infrastructure Components

- Base infrastructure (`terraform/infrastructure/base/`)
- Application-specific infrastructure (`terraform/infrastructure/application/`)
- Network configuration
- Security settings

## Configuration

### Jenkins

A dedicated Jenkins server serves as the CD tool for environments. It:

- Automates the deployment process
- Executes Ansible playbooks
- Manages deployment pipelines
- Monitors deployment status

### Applications

Applications are containerized and deployed using:

- Docker containers
- Docker Compose for orchestration
- Nginx reverse proxy for routing
- Automated SSL certificate management

## CI/CD Pipeline

The CI/CD pipeline is implemented using Jenkins, Terraform, and Ansible:

### Infrastructure Provisioning (Terraform)

- Base infrastructure components in `terraform/infrastructure/base/`
- Application-specific infrastructure in `terraform/infrastructure/application/`
- Infrastructure is provisioned in Digital Ocean's Singapore (`sgp1`) region

### Deployment Automation (Ansible)

- `site-deploy.yml`: Main deployment playbook that orchestrates the deployment process
- Key Ansible roles:
  - `deploy/`: Handles application deployment
  - `reverse-proxy/`: Configures Nginx reverse proxy
  - `lets-encrypt/`: Manages SSL certificates
  - `prerequisites/`: Sets up required system dependencies

### CI/CD Flow

1. Infrastructure is provisioned using Terraform
2. Jenkins triggers the deployment process
3. Ansible playbooks execute in sequence:
   - Prerequisites installation
   - Application deployment
   - Reverse proxy configuration
   - SSL certificate management

## Prerequisites

Before using this infrastructure, ensure you have:

- Digital Ocean account with API access
- Terraform installed (version >= 1.0.0)
- Ansible installed (version >= 2.9)
- Jenkins server configured
- SSH access to target servers

## Getting Started

1. Clone this repository
2. Configure your Digital Ocean API token
3. Initialize Terraform:
   ```bash
   cd terraform/infrastructure
   terraform init
   ```
4. Apply infrastructure:
   ```bash
   terraform apply
   ```
5. Configure Jenkins jobs for deployment

## Security Considerations

- All infrastructure components are secured with appropriate firewall rules
- SSH access is restricted to necessary IPs
- SSL certificates are automatically managed and renewed
- Sensitive credentials are stored securely

### Important Security Steps

- `jenkins` user in CI/CD server should be able to SSH into the `root` user of application server
- `root` user of the application server should be able to pull repositories from Gitlab
- Ensure proper SSH key management
- Regularly rotate credentials and certificates

