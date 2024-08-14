# WeaveSocks Infrastructure

This repo contains the Amazon Web Services (AWS) IaaC (Infrastructure as Code) for **WeaveSocks**'s sock shop, which is a microservices-based application deployed on kubernetes. It also serves as the solution to my AltSchool Capstone Project.

- **Name: Ilodiuba Victor Nnamdi**
- **School: School of Engineering**
- **Track: Cloud Engineering**
- **ID No: ALT/SOE/023/3812**

## Table of Contents

- [Objective](#objective)
  - [Resources](#resources)
- [Infrastructure Diagram](#infrastructure-diagram)
- [File Structure](#file-structure)
- [Deployment Pipeline](#deployment-pipeline)
- [Monitoring and Alerts](#monitoring-and-alerts)

## Objective

We aim to deploy a microservices-based application, specifically the Socks Shop, using a modern approach that emphasizes automation and efficiency. The goal is to use Infrastructure as Code (IaaC) for rapid and reliable deployment on Kubernetes.

### Resources

Socks Shop's Microservices Kubernetes manifests can be found on: https://github.com/microservices-demo/microservices-demo/tree/master/deploy/kubernetes

## Infrastructure Diagram

## File Structure

The following is an overview of the file structure for this project:

```
weavesocks-infrastructure/
├── aws/
├── helm/
├── k8s/
├── init.tf
├── main.tf
└── variables.tf
```

- [aws](./aws/): Contains the infrastructure for all Amazon Web Services used for this deployment. To see more information on the AWS infrastructure, check the the README file [here](./aws/)
- [helm](./helm/): Contains the infrastructure for Helm chart repositories and installation for the EKS cluster.
- [k8s](./k8s/): Contains the infrastructure for all kubernetes resources required for the kubernetes deployment.
- [main.tf](main.tf): Contains the main infrastructure setup
- [init.tf](init.tf): Contains Initialization configuration for Terraform
- [variables.tf](variables.tf): Contains the variables used in Terraform

To see more information about each infrastructure, open their directories.

## Deployment Pipeline

The CI/CD pipeline is handled by GitHub Actions. The workflow is contained in [.github/workflows/deploy.yml](./.github/workflows/deploy.yml). It installs the latest version of Terraform CLI and configures the Terraform CLI configuration with an API token for Terraform Cloud. On pull request events, the workflow will run `terraform init`, `terraform fmt`, and `terraform plan`. On push events to the "master" branch, `terraform apply` will be executed.

To use the workflow, a Terraform Cloud user API token was generated and stored as a GitHub secret which was then referenced in the [workflow file](./.github/workflows/deploy.yml).

A Terraform Cloud user account was used so the state of all resources could be stored and retrieved by GitHub Actions and also it can available to anyone with access to the Terraform Cloud user account.

Environment variables and Terraform variables were also stored in the user account's organisation workspace to provide security for sensitive data.

## Monitoring and Alerts

Service monitoring and alerts are handled by Prometheus, Grafana, and AlertManager. Their configuration and more details about them can be found at [k8s/monitoring](./k8s/monitoring/).
