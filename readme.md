# Azure Automation Project with Terraform and Ansible

This project demonstrates the implementation of Infrastructure as Code (IaC) and Configuration as Code (CaC) principles using Terraform and Ansible on Microsoft Azure cloud platform. The goal is to build a highly available, scalable, and secure infrastructure with automated configuration of guest operating systems.

## Project Overview

This project automates the deployment of a complete infrastructure on Azure, including virtual machines, networking components, load balancers, and storage solutions. It also configures the deployed virtual machines using Ansible roles for various system administration tasks.

The infrastructure consists of multiple Linux VMs behind a load balancer hosting a web application that demonstrates high availability. Windows VMs are also provisioned as part of the infrastructure.

## Technologies Used

- **Terraform**: For infrastructure provisioning
- **Ansible**: For configuration management
- **Microsoft Azure**: Cloud platform

## Project Structure

```
.
├── ansible
│   ├── inventory
│   ├── n01514804-playbook.yml
│   ├── roles
│   │   ├── datadisk-n01514804
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   └── vars
│   │   │       └── main.yml
│   │   ├── profile-n01514804
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   ├── user-n01514804
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   └── webserver-n01514804
│   │       ├── handlers
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   └── main.yml
│   │       └── templates
│   │           ├── vm1.html.j2
│   │           ├── vm2.html.j2
│   │           └── vm3.html.j2
│   └── user100_private_keys
│       └── id_rsa
├── backend.tf
├── main.tf
├── modules
│   ├── common-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── database-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── datadisk-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── loadbalancer-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── network-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── rgroup-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── terraform.tfstate
│   ├── vmlinux-n01514804
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── provisioner.tf
│   │   └── variables.tf
│   └── vmwindows-n01514804
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── providers.tf
├── readme.md
└── variables.tf
```

## Terraform Components

### Root Module
- **providers.tf**: Azure provider configuration
- **backend.tf**: Remote state storage configuration
- **main.tf**: Module calls and resource definitions
- **outputs.tf**: Output values
- **variables.tf**: Input variables

### Child Modules
1. **rgroup-n01514804**: Creates resource group
2. **network-n01514804**: Sets up virtual networks, subnets, and peering
3. **common-n01514804**: Provisions common resources like storage accounts
4. **vmlinux-n01514804**: Creates Linux virtual machines
5. **vmwindows-n01514804**: Creates Windows virtual machines
6. **datadisk-n01514804**: Manages data disks for VMs
7. **loadbalancer-n01514804**: Configures load balancer for web servers
8. **database-n01514804**: Sets up database services

## Terraform Features Used

- **Modular Architecture**: The project is structured with separate modules for different components, promoting code reusability and easier management
- **Remote Backend**: Terraform state is stored in Azure Blob Storage for team collaboration and state locking
- **Resource Parameterization**: Extensive use of variables, locals, and outputs to make the infrastructure code flexible and reusable
- **Provisioner Integration**: Null provisioner is used to trigger Ansible playbook execution after infrastructure deployment
- **Dynamic Resource Creation**: Multiple similar resources are created using count and for_each meta-arguments
- **Output Management**: Outputs are structured to provide essential information about the deployed resources
- **Dependency Management**: Implicit and explicit dependencies are correctly managed for proper resource creation order
- **Resource Tagging**: All resources are tagged consistently for better resource management and cost tracking
- **State Management**: Proper state handling ensures idempotent deployments and accurate tracking of resource changes

## Ansible Components

### Playbook
- **n01514804-playbook.yml**: Main playbook that orchestrates the execution of all roles

### Ansible Roles Developed

1. **profile-n01514804**:
   - Appends specific lines to `/etc/profile` file
   - Sets system timeout value for better security
   - Role demonstrates file manipulation capabilities in Ansible

2. **user-n01514804**:
   - Creates a system group called `cloudadmins`
   - Adds three user accounts (`user100`, `user200`, `user300`) using loops
   - Assigns users to the `cloudadmins` and `wheel` groups
   - Generates SSH keys for each user without passphrases
   - Downloads private key for one user for administrative access
   - Role demonstrates user management, security configuration, and iteration in Ansible

3. **datadisk-n01514804**:
   - Partitions 10GB data disks into specific sized partitions
   - Creates a 4GB partition with XFS filesystem mounted at `/part1`
   - Creates a 5GB partition with EXT4 filesystem mounted at `/part2`
   - Ensures persistent mounting through `/etc/fstab` updates
   - Role demonstrates storage management and filesystem operations in Ansible

4. **webserver-n01514804**:
   - Installs and configures Apache web server
   - Creates custom HTML files for each virtual machine
   - Sets proper file permissions (0444) for web content
   - Uses handlers to manage service restarts
   - Configures service for automatic startup on system boot
   - Role demonstrates application deployment, service management, and templating in Ansible

## Terraform and Ansible Integration

The integration between Terraform and Ansible represents a key component of this project:

1. **Dynamic Inventory Generation**:
   - Terraform creates the infrastructure and dynamically populates the Ansible inventory file
   - VM hostnames, IP addresses, and other relevant details are passed from Terraform to Ansible

2. **Automated Playbook Execution**:
   - Terraform's null_resource provisioner triggers the Ansible playbook execution
   - The provisioner waits for SSH connectivity before running the Ansible playbook
   - This ensures configuration happens immediately after infrastructure is available

3. **Secure Authentication**:
   - SSH keys generated by Terraform are used by Ansible for secure access to VMs
   - No passwords are stored or transmitted during the automation process

4. **Information Sharing**:
   - Terraform outputs essential information that Ansible needs for configuration
   - Variables are passed between the two tools for consistent configuration

## Implementation Details

### Infrastructure Provisioning

1. All resources are created in a single resource group
2. All resource names are prefixed with "n01514804" to ensure uniqueness
3. Virtual machines are deployed with B1ms VM size and LRS storage SKU
4. Terraform state is stored in Azure backend for team collaboration

### Configuration Management

1. Ansible roles are parameterized for flexibility
2. The playbook applies all roles to the Linux inventory nodes
3. Configuration includes:
   - System profile updates
   - User and group management
   - Disk partitioning and mounting
   - Web server setup with load balancing

## Deployment Steps

1. **Prerequisites**:
   - Azure subscription free or pay as you go
   - Terraform installed
   - Ansible installed
   - Git installed

2. **Initial Setup**:
   ```bash
   # Clone the repository
   git clone <repository-url>
   cd azure-automation-n01514804
   
   # Initialize Terraform
   terraform init
   ```

3. **Deployment**:
   ```bash
   # Validate the Terraform configuration
   terraform validate
   
   # Preview the changes
   terraform plan
   
   # Apply the changes
   terraform apply --auto-approve
   ```

4. **Validation**:
   ```bash
   # List all resources in the Terraform state
   terraform state list | nl
   
   # View outputs
   terraform output
   ```

5. **Access Web Application**:
   - Use the load balancer's FQDN in a web browser with HTTP protocol
   - Refreshing every few seconds will show different backend servers, demonstrating load balancing

## Troubleshooting

### Common Issues and Solutions

1. **SSH Connection Timeouts**:
   - Ensure network security groups allow SSH (port 22) traffic
   - Verify that the VM is running and accessible
   - Check SSH key permissions (should be 600 for private keys)

2. **Ansible Playbook Failures**:
   - Check the Ansible inventory file for correct host definitions
   - Ensure Python is installed on target VMs
   - Verify that the Ansible roles are correctly defined and accessible

3. **Load Balancer Issues**:
   - Verify that backend pool members are properly registered
   - Check health probe configuration
   - Ensure network security groups allow HTTP traffic (port 80)

4. **Disk Mounting Problems**:
   - Verify that disks are properly attached to VMs
   - Check disk partitioning commands in the datadisk role
   - Ensure proper filesystem creation and mount point existence

5. **State File Conflicts**:
   - Use state locking to prevent concurrent modifications
   - Properly manage the backend configuration
   - Implement proper team workflows for state management

## Technical Skills Demonstrated

This project demonstrates a wide range of technical skills:

1. **Infrastructure as Code (IaC)**:
   - Declarative infrastructure definition
   - Version-controlled infrastructure
   - Idempotent resource management

2. **Configuration as Code (CaC)**:
   - Declarative system configuration
   - Role-based configuration management
   - Idempotent system state management

3. **Cloud Architecture**:
   - High availability design patterns
   - Load balancing implementation
   - Security best practices
   - Cost optimization strategies

4. **DevOps Practices**:
   - Automation of deployment and configuration
   - Infrastructure testing
   - Version control
   - Collaboration through code

5. **System Administration**:
   - User and group management
   - Storage configuration
   - Web server deployment and configuration
   - Security hardening

## Reflections

The implementation of this project revealed several important insights:

- **Modular Infrastructure Design**: Breaking down the infrastructure into modules significantly improved code maintainability and reusability.

- **Configuration Parameterization**: Parameterizing both Terraform and Ansible code allowed for greater flexibility and adaptability to different environments.

- **Integration Challenges**: The integration between Terraform and Ansible required careful planning to ensure proper handoff of information and timing of operations.

- **State Management**: Proper state management in Terraform proved crucial for maintaining infrastructure integrity and enabling team collaboration.

- **Idempotency Importance**: Ensuring idempotent operations in both Terraform and Ansible was essential for reliable, repeatable deployments.

## Conclusion

This project successfully demonstrates the power of automation in cloud infrastructure management using Terraform and Ansible. By codifying both infrastructure and configuration, we've created a reproducible, scalable, and maintainable solution that could be adapted to various environments and requirements.

The integration of Terraform for infrastructure provisioning and Ansible for configuration management creates a comprehensive end-to-end automation solution that addresses the complexities of modern cloud deployments.

## Key Takeaways

- **Infrastructure as Code**: Terraform provides a powerful, declarative approach to defining and managing infrastructure.

- **Configuration as Code**: Ansible offers a flexible, idempotent way to manage system configuration across multiple hosts.

- **Tool Integration**: Combining specialized tools like Terraform and Ansible creates a more comprehensive automation solution than either tool alone.

- **Modularity**: Breaking down complex systems into smaller, focused modules improves maintainability and reusability.

- **Parameterization**: Making code configurable through parameters enhances flexibility and adaptability.

- **Documentation**: Comprehensive documentation is essential for understanding, using, and maintaining automation code.

- **Testing**: Thorough testing of automation code is crucial for ensuring reliability and preventing issues in production.

## Resource Tags

All resources are tagged with:
- Project = "CCGC 5502 Automation Project"
- Name = "hunny.shah"
- ExpirationDate = "2024-12-31"
- Environment = "Project"

## Cost Management

Virtual machines are configured to be shut down when not in use to optimize costs. The project uses minimal compute resources (B1ms VM size) and the cheapest storage and database options available.

## Author

Hunny Shah (n01514804)