# Introduction

This Terraform module creates a Azure Event Hub.

## Prereqs

1. Azure subscription - TODO: Link to process
2. SPN ID and Secret loaded in Azure key vault for your subcription - TODO: Link to process
3. Azure DevOps project in https://humana.visualstudio.com - TODO: Link to process
4. Azure DevOps connection configured to your destination Azure subscription - TODO: Link to process
5. Vitual Network and Subnet. 
6. For restricting access to an Event Hub Namespace to only come from specific virtual networks / subnets, a subnet is required which is having Service Endpoint=Microsoft.EventHub

## Usage

1. Clone repository
2. Update azure_backend.tfvars for each environment to meet your needs
3. Update all .tfvars to match your needs
4. Update tags.tf to match your needs

## Reference Azure DevOps Build

- Humana Visual Studio link for Azure Event Hub
