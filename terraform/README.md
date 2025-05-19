# Terraform Infrastructure as Code

This repository contains Terraform configurations for deploying infrastructure on DigitalOcean.

## Project Structure

```
terraform/
├── modules/                  # Reusable Terraform modules
│   ├── vpc/                  # VPC network configuration
│   ├── ssh_key/             # SSH key management
│   ├── space_bucket/        # Object storage configuration
│   ├── droplet/             # Droplet (VM) configuration
│   ├── droplet_firewall/    # Droplet firewall rules
│   ├── database/            # Database configuration
│   └── database_firewall/   # Database firewall rules
│
├── infrastructure/          # Environment-specific configurations
│   ├── base/               # Base infrastructure components
│   │   └── dev/            # Development environment base config
│   └── application/        # Application-specific infrastructure
│       ├── dev/            # Development environment app config
│       └── cicd/           # CI/CD pipeline infrastructure
```

## File Types and Their Purposes

### Essential Configuration Files

1. **provider.tf**

   - Defines the cloud provider (DigitalOcean) configuration
   - Contains provider version constraints
   - Specifies authentication and region settings
   - **Required**: Yes, this file is mandatory for Terraform to work

2. **main.tf**

   - Contains the main resource definitions
   - Defines the infrastructure components
   - **Required**: Yes, this is the core configuration file

3. **variables.tf**

   - Defines input variables for the configuration
   - Specifies variable types, descriptions, and default values
   - **Required**: Yes, for configurable deployments

4. **outputs.tf**
   - Defines output values from the configuration
   - Makes certain values available to other configurations
   - **Required**: Recommended for sharing values between modules

### Optional Configuration Files

5. **data.tf**

   - Contains data source definitions
   - Used to fetch information about existing resources
   - Makes external data available to your configuration
   - **Required**: No, but useful for referencing existing resources
   - Can be merged into main.tf if there are few data sources

6. **terraform.tfvars**

   - Contains variable values for the configuration
   - Used to set actual values for variables defined in variables.tf
   - **Required**: No, but recommended for managing environment-specific values
   - ⚠️ **Important**: This file should not be committed to version control if it contains sensitive information

7. **versions.tf**
   - Specifies required provider and Terraform versions
   - Ensures consistent behavior across different environments
   - **Required**: Recommended for production use

## Getting Started

1. Install Terraform (version >= 1.0.0)
2. Configure DigitalOcean API token
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the planned changes:
   ```bash
   terraform plan
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Security Considerations

- Never commit `terraform.tfvars` files containing sensitive information
- Use environment variables or a secrets management solution for sensitive values
- Regularly rotate API tokens and SSH keys
- Review and update firewall rules regularly

## Best Practices

1. Always use version constraints in provider.tf
2. Document all variables in variables.tf
3. Use meaningful names for resources and variables
4. Regularly update provider and module versions
5. Use remote state storage for team collaboration
6. Implement proper tagging and naming conventions

## Support

For questions or issues, please open an issue in the GitHub repository.
