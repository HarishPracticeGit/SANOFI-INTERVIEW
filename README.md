# Terraform Azure Infrastructure Deployment - README

## Overview

This repository contains Terraform configurations for deploying Azure infrastructure across development (dev) and production (prod) environments. The infrastructure includes virtual networks, subnets, and virtual machines with associated networking components.

## Repository Structure

```
.
├── .github/
│   └── workflows/
│       ├── terraform_dev.yml      # GitHub Actions workflow for dev environment
│       └── terraform_prod.yml     # GitHub Actions workflow for prod environment
├── modules/
│   ├── compute/                   # Reusable compute module (VMs, NICs, Public IPs)
│   │   ├── nic.tf
│   │   ├── public_ip.tf
│   │   ├── variables.tf
│   │   └── virtual_machine.tf
│   └── network/                   # Reusable network module (VNets, Subnets)
│       ├── subnet.tf
│       ├── variables.tf
│       └── vnet.tf
├── dev/                           # Dev environment configurations
│   ├── data.tf                    # Data sources for dev
│   ├── terraform.tf               # Terraform settings for dev
│   ├── vm.tf                      # VM definitions for dev
│   └── vnet.tf                    # VNet definitions for dev
└── prod/                          # Prod environment configurations
    ├── data.tf                    # Data sources for prod
    ├── terraform.tf               # Terraform settings for prod
    ├── vm.tf                      # VM definitions for prod
    └── vnet.tf                    # VNet definitions for prod
```

## Workflow Overview

### 1. GitHub Actions CI/CD Pipeline

Two separate workflows are configured to manage infrastructure changes:

#### Development Environment Workflow (`terraform_dev.yml`)
- **Trigger**: Changes pushed to files in the `dev/` directory
- **Actions**:
  1. Checks out the repository
  2. Sets up Terraform CLI (v1.0.10)
  3. Initializes Terraform with Azure backend configuration
  4. For pull requests:
     - Runs `terraform plan` to show proposed changes
  5. For direct pushes to main branch:
     - Runs `terraform apply -auto-approve` to implement changes

#### Production Environment Workflow (`terraform_prod.yml`)
- **Trigger**: Changes pushed to files in the `prod/` directory
- **Actions**:
  1. Similar steps as dev workflow
  2. Uses different storage account for state files (`STORAGE_ACCOUNT_PROD`)
  3. More restrictive apply conditions (only on main branch)

### 2. Module Usage

The infrastructure is built using reusable Terraform modules:

#### Compute Module (`modules/compute`)
- Creates:
  - Virtual Machines
  - Network Interfaces
  - Optional Public IP addresses
- Configurable via variables:
  - VM name, size, credentials
  - Networking details (subnet ID)
  - Public IP creation flag
  - Tags

#### Network Module (`modules/network`)
- Creates:
  - Virtual Networks
  - Subnets
  - Outputs subnet IDs for compute resources
- Configurable via variables:
  - VNet name, address space
  - Subnet definitions (name, address prefixes)
  - Tags

### 3. Environment Configurations

#### Development Environment (`dev/`)
- **Resources**:
  - 2 Virtual Networks (East US and West US)
    - Each with 2 subnets
  - 2 Virtual Machines (one in each region)
- **Configuration**:
  - Uses `sanofi-dev-rg` resource group
  - Retrieves credentials from `sanofi-keyvault`
  - Tags all resources with `environment = "dev"`

#### Production Environment (`prod/`)
- **Resources**:
  - 2 Virtual Networks (both in East US)
    - Each with 2 subnets
  - 1 Virtual Machine (in first VNet)
- **Configuration**:
  - Uses `sanofi-prod-rg` resource group
  - Retrieves credentials from same keyvault as dev
  - Tags all resources with `environment = "prod"`

## Security Considerations

1. **Credentials Management**:
   - VM admin credentials are retrieved from Azure Key Vault
   - Never stored in plaintext in configuration

2. **State Files**:
   - Terraform state is stored securely in Azure Storage
   - Separate storage accounts for dev and prod

3. **Workflow Security**:
   - Apply operations only run on main branch
   - Pull requests require review before merge

## Deployment Flow

1. **Developer Makes Changes**:
   - Modifies files in either `dev/` or `prod/` directory
   - Creates pull request for review

2. **CI Pipeline Triggers**:
   - Runs `terraform plan` to show proposed changes
   - Requires approval for production changes

3. **Merge to Main**:
   - Triggers `terraform apply` automatically
   - Changes are implemented in the target environment

4. **State Management**:
   - Terraform state is updated in Azure Storage
   - Subsequent runs use this state to determine changes

## Maintenance Notes

1. **Module Updates**:
   - Changes to modules affect both environments
   - Test changes thoroughly before merging

2. **Environment Isolation**:
   - Dev and prod use separate resource groups
   - Separate state files prevent accidental cross-environment changes

3. **Version Control**:
   - Terraform version is pinned (1.0.10)
   - Provider versions are constrained (~> 2.0)

This structure provides a clear separation of concerns between environments while maximizing code reuse through modules, with automated deployment workflows enforcing proper change management practices.