# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

The project involves buildiing end-to-end DevOps Pipelines to support a web applicatoin and manage the deliveries across the platform. 

## Table of Contents

- [Project Overview](#Project-Overview)
- [Getting Started](#getting-started)
- [Version Control](#version-control)
- [Docker Containerisation ](#docker-containerisation)
- [Network services with IaC](#network-services-with-iac)
- [AKS Cluster with IaC](#aks-cluster-with-iac)
- [Kubernetes deployment in AKS](#Project-Overview)
- [CI/CD Pipeline in Azure DevOps](#cicd-pipeline-in-azure-devops)
- [AKS Cluster Monitoring](#aks-cluster-monitoring)
- [AKS Integration with Azure Key Vaults for Secrets Management](#aks-integration-with-azure-key-vaults-for-secrets-management)

## Project Overview

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

- **Project DevOps Sided:** The project implemented version control and containersiation. The prooject included packing the application and the dependencies built using Docker which also allows the project to scale and be used on different platforms. The project uses IaC to manage the resources and dependencies using Azure and kubernetes which contained the project and employed CI/CD practice to automate the deployment of the project.

## Getting Started

Initialising the project on a github repository and produce branches to implement changes to the repository

## Version Control 

The project was cloned onto a local machine to implement changes such as adding a delivery_date column and push changes to a remote branch. I then tested different Git requests before reverting the changes of the branch.

### Docker Containerisation 

The project used Docker to containerise the Web Application - This was done by using a Dockerfile to define the application environment and the needed configuration settings and dependencies for the build. 

The docker image was built using the command docker build but it had to be altered to fit the M2 chip. 
After building the image the project was ran locally using different map ports to test the features of the web application. 

After testing the project the image was tagged and pushed to Docker Hub using docker tag and docker push. The project could then be viewed and verified on the Docker Hub.

### Network services with IaC

The task of this section of the project was to define the networking services using Infrastructer as Code with Terraform by creating a terraform project that defined two modules called: 
networking-module and aks-cluster-module

Firstly the two directories for the terraform modules were created and then later I defined the terraform files: variables.tf which held the resource_group_name, location and vnet_address_space in the networking-module directory. 

The next step was to define the output variables in outputs.tf which was also in the networking-module directory which included the variables vnet_id, control_plane_subnet_id, worker_node_subnet_id, worker_node_subnet_id, networking_resource_group_name and aks_nsg_id.

The project was then itialised.

### AKS Cluster with IaC

To create the AKS cluster module I had to define inputs in the variables.tf file in the aks-cluster-module directory. 

The Azure resources for provisioning the AKS cluster were defined in the main.tf and outputs.tf file located in the aks-cluster-module directory. 

After provisioning the resources the aks-cluster-module was initialised within the main project.

The main.tf file was defined in the netwokring module to define the Azure provideer block which enabled authentication to Azure using the service principal credentials. 

The next step was to integrate the main.tf in the networking-module. After the integration I initialised the terraform in the main project directory to apply the configurations set by terraform that will define the infrastructure.

Using az aks get-credentials --resource-group <your-resource-group> --name <your-aks-cluster-name> the kubeconfig file could be retireved to allow the project to connect to the AKS cluster.

## Kubernetes deployment in AKS

The service was defined in application-manifest.yaml. 
Later the project would be tested by validating the port forwarding on a local machine using the command kubectl port-forward <pod-name> 50001:5000 which allowed the project to be accessed locally through http://127.0.0.1:5001.

## CI/CD Pipeline in Azure DevOps

This section of the project focused on using continuous integration and continuous deployment (CI/CD) in Azure DevOps to automate the application deployment. 

This was set by creating an Azure DevOps project to build the pipeline setup. 
A connection to Docker Hub was set to facilitate the integration of CI/CD Pipelines where the project could be built and pushed. 

## AKS Cluster Monitoring 

This section of the project was to enable container insights for AKS in order to create metric charts: 
These can be found within the Images folder. 

An alarm was set up following an alert rule to trigger when the used disk percentage in the AKS cluster exceeded 90%

## AKS Integration with Azure Key Vaults for Secrets Management 

In this section of the project being the last section worked a Azure Kubernetes Service with an Azure Key Vault to secure management of secrets was implemented. The Azure Key Vault was assigned to the Key Vault Administrator role which enabled the project to create secrets in the Key Vault of Azure and enabled managed identities for AKS where permissions could be assigned to the managed identity.

Firstly an Azure Key Vault was created and then the Key Vault Administrator role was assigned to the member to manage the secrets within the Key Vault. 
Managed identity was enabled for the AKS cluster to authenticate the secure Key Vault where permissions were assigned to the managed identity of the Key Vault Secrets Officer role.

In the Python project the Azure Key Vault and Azure Idenity libraries were integrated to manage identity credentials to securely retrieve access to the database from the Key Vault.
