# CCGC 5502 Terraform Project - Assignment 1

## Project Overview
This project is designed to automate the provisioning of infrastructure on Microsoft Azure using Terraform. It includes setting up various Azure resources such as resource groups, virtual networks, security groups, virtual machines (Linux and Windows), storage accounts, databases, and load balancers.

## Prerequisites
Before deploying this infrastructure, ensure you have the following:

1. **Azure Account** (Azure for Students or a standard subscription)
2. **Terraform Installed** (Download from [Terraform](https://www.terraform.io/downloads))
3. **Azure CLI Installed** (Download from [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli))
4. **Configured Azure CLI** (Run `az login` to authenticate)
5. **Git Installed** (Download from [Git](https://git-scm.com/downloads))


## Project Structure
The project follows a modular Terraform structure:

```
assignment1-n01514804/
│── modules/
│   ├── rgroup-n01514804/            # Resource Group Module
│   ├── network-n01514804/           # Networking Module
│   ├── common-n01514804/            # Common Services Module
│   ├── vmlinux-n01514804/           # Linux Virtual Machines Module
│   ├── vmwindows-n01514804/         # Windows Virtual Machines Module
│   ├── datadisk-n01514804/          # Data Disks Module
│   ├── loadbalancer-n01514804/      # Load Balancer Module
│   ├── database-n01514804/          # Database Module
│── main.tf                          # Root module defining all child modules
│── variables.tf                      # Input variables
│── outputs.tf                        # Output values
│── providers.tf                      # Provider configurations
│── backend.tf                        # Terraform backend storage
│── README.md                         # Project documentation
```

## Infrastructure Components
- **Resource Group**: `n01514804-RG`
- **Networking**: Virtual network (`n01514804-VNET`), Subnet (`n01514804-SUBNET`), Security Group (`n01514804-NSG`)
- **Common Services**: Log Analytics Workspace, Recovery Services Vault, Storage Account
- **Virtual Machines**:
  - 2 Linux VMs in an availability set
  - 1 Windows VM in an availability set
- **Data Disks**: 3 x 10GB disks attached to VMs
- **Load Balancer**: A public-facing basic load balancer for Linux VMs
- **Database**: PostgreSQL Single Server instance

## Usage
### 1. Clone the Repository
```sh
git clone https://github.com/yourusername/assignment1-n01514804.git
cd assignment1-n01514804
```

### 2. Configure Terraform Backend Storage
Modify the `backend.tf` file to match your Azure storage account details.

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateN01514804RG"
    storage_account_name = "tfstaten01514804unique"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

### 3. Initialize Terraform
```sh
terraform init
```

### 4. Validate Configuration
```sh
terraform validate
```

### 5. Plan the Deployment
```sh
terraform plan
```

### 6. Apply the Deployment
```sh
terraform apply --auto-approve
```

### 7. View Deployed Resources
```sh
terraform state list | nl
terraform output
```

### 8: Access the VMs
To SSH into a Linux VM:
```bash
ssh azureuser@<linux_vm_public_ip>
```
To RDP into a Windows VM:
1. Open **Remote Desktop Connection**
2. Enter `<windows_vm_public_ip>`
3. Login with provided credentials

### 9. Destroy the Infrastructure (After Marking)
```sh
terraform destroy --auto-approve
```

## Tags
All resources include the following tags:
```
Assignment = "CCGC 5502 Automation Assignment"
Name = "hunny.shah"
ExpirationDate = "2024-12-31"
Environment = "Learning"
```

## Troubleshooting

### 1. Terraform Init Fails
- Ensure you are logged into Azure with `az login`.
- Check your `backend.tf` configuration.

### 2. Public IP Limit Reached
- Azure Student accounts allow only **3 Public IPs**.
- Consider using **Private IPs** or a **NAT Gateway**.

### 3. Virtual Machines Not Reachable
- Check **Network Security Group (NSG)** rules.
- Ensure **Load Balancer Health Probe** is correctly set up.

### 4. Storage Account Name Already Taken
- Azure storage account names must be globally unique.
- Modify `providers.tf` to use a unique name.

**Author:** Hunny Shah (N01514804)  
**Course:** CCGC 5502 - Automation with Terraform 

## Contributors
- **Hunny Shah** - [GitHub Profile](https://github.com/hunnyshah)